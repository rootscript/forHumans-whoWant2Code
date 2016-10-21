--elm 0.17.1


module Main exposing (..)

import Html exposing (Html, text, div, ul, li)
import Html.App as Html
import Mouse exposing (..)
import String exposing (dropLeft, dropRight, toInt)
import Array exposing (Array, fromList, get)
import Regex exposing (replace, regex, Match, Regex)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    List String


model : Model
model =
    [ "Hello"
    , "World"
    ]


type Msg
    = None



--type alias Model =
--    { xAxis : Int
--    , yAxis : Int
--    }
--
--
--initialModel : Model
--initialModel =
--    { xAxis = 0
--    , yAxis = 0
--    }
--
--


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )



--
-- UPDATE
--
--type Msg
--    = Position Int Int
--
--update : Msg -> Model -> ( Model, Cmd a )


update msg model =
    model



--    case msg of
--        Position x y ->
--            ( { model | xAxis = x, yAxis = y }, Cmd.none )
--
-- SUBSCRIPTIONS
--
--subscriptions : Model -> Sub Msg
--subscriptions model =
--    Mouse.moves (\{ x, y } -> Position x y)
--
-- VIEW


view : Model -> Html Msg
view model =
    ul []
        (List.map (\m -> li [] [ text m ]) model)



--output : String
--output =
--    interpolate "My order is {0} {2} {1}" [ "one", "two", "there" ]
--
--
--view : Model -> Html a
--view model =
--    Html.text output
