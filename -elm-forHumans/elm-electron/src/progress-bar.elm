--elm 0.18.0


module Main exposing (..)

import Http
import Http.Progress as Progress exposing (Progress(..))
import Html exposing (..)
import Html.Events exposing (onCheck)
import Html.Attributes exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd a )
init =
    ( initModel, Cmd.none )



-- Model


type alias Model =
    { progress : Progress String
    , bookUrl : Maybe String
    , bookContent : String
    }


initModel : Model
initModel =
    { progress = Progress.None
    , bookUrl = Nothing
    , bookContent = ""
    }



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.bookUrl of
        Just bookUrl ->
            Http.getString bookUrl
                |> Progress.track bookUrl GetBookProgress

        Nothing ->
            Sub.none



-- Update


type Msg
    = NoOp
    | GetBook String
    | GetBookProgress (Progress String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        GetBook url ->
            ( { model | bookUrl = Just url }, Cmd.none )

        GetBookProgress (Done bookContent) ->
            ( { model
                | progress = Done ""
                , bookContent = bookContent
              }
            , Cmd.none
            )

        GetBookProgress (Fail error) ->
            ( { model
                | progress = Fail error
                , bookContent = toString error
              }
            , Cmd.none
            )

        GetBookProgress progress ->
            ( { model | progress = progress }, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    div [ viewStyle ]
        [ h1 [] [ text "Elm Http.Progress example" ]
        , p []
            [ text "Select a book:"
            , inputRadio "Essays - Ralph Waldo Emerson" "https://phirafuji.websiteseguro.com/elm/essays/"
            , inputRadio "Leviathan - Thomas Hobbes" "https://phirafuji.websiteseguro.com/elm/leviathan/"
            , inputRadio "The Ethics of Aristotle - Aristotle" "https://phirafuji.websiteseguro.com/elm/ethics/"
            ]
        , progressView <|
            toString <|
                progressLoaded model.progress
        , bookContentView model.bookContent
        , footerView
        ]


inputRadio : String -> String -> Html Msg
inputRadio labelText url =
    div []
        [ label
            [ onCheck
                (\isChecked ->
                    if isChecked then
                        GetBook url
                    else
                        NoOp
                )
            ]
            [ input [ type_ "radio", name "book-radio" ] []
            , text labelText
            ]
        ]


progressView : String -> Html Msg
progressView loaded =
    div []
        [ span [] [ text "Progress: " ]
        , progress
            [ value loaded
            , Html.Attributes.max "100"
            ]
            [ text <| loaded ++ "%" ]
        , text <| loaded ++ "%"
        ]


progressLoaded : Progress String -> Int
progressLoaded progress =
    case progress of
        Some { bytes, bytesExpected } ->
            round <|
                (*) 100 <|
                    toFloat bytes
                        / toFloat bytesExpected

        Done _ ->
            100

        _ ->
            -- None or Fail case
            0


bookContentView : String -> Html Msg
bookContentView valueText =
    div []
        [ textarea
            [ value valueText
            , disabled True
            , bookContentViewStyle
            ]
            []
        ]


footerView : Html Msg
footerView =
    span []
        [ a
            [ href "https://gist.github.com/pablohirafuji/fa373d07c42016756d5bca28962008c4"
            , target "_blank"
            ]
            [ text "Source" ]
        , text " | "
        , text "Books from "
        , a
            [ href "http://www.gutenberg.org/"
            , target "_blank"
            ]
            [ text "Project Gutenberg" ]
        ]



-- Styles


viewStyle : Attribute Msg
viewStyle =
    style
        [ ( "display", "flex" )
        , ( "flex-direction", "column" )
        , ( "width", "550px" )
        , ( "margin", "0 auto" )
        , ( "font-family", "Arial" )
        ]


bookContentViewStyle : Attribute Msg
bookContentViewStyle =
    style
        [ ( "height", "400px" )
        , ( "width", "100%" )
        ]
