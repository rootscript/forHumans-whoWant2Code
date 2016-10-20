module Main exposing (..)

--if you are using http://elm-lang.org/try - don't include this line 'module Main exposing (..)'

import Html exposing (..)
import Html.App exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Http
import Task exposing (Task)
import Json.Decode as Json exposing ((:=))


-- MODEL
-- define a type alias - The RepoInfo value is a record with three fields:


type alias RepoInfo =
    { id : Int
    , name : String
    , full_name : String
    }



-- define a Model type alias that describes the data
--Model has 2 properties


type alias Model =
    { messagePlaceholder : String
    , repoList : List RepoInfo
    }



-- model is a list of repos & a messagePlaceholder string;
--we initialize model using the empty list & text, that will be there when the app starts


init =
    let
        model =
            { messagePlaceholder = "Hello, Elm!"
            , repoList = []
            }
    in
        model ! []



--program is looking for 3 properties (model, view , update)


main =
    Html.App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }



--This decoder uses Json.Decode.object3 to extract 3 fields from a JSON value
--(id, name, full_name) and then constructs a RepoInfo value


repoInfoDecoder : Json.Decoder RepoInfo
repoInfoDecoder =
    Json.object3
        RepoInfo
        ("id" := Json.int)
        ("name" := Json.string)
        ("full_name" := Json.string)



{- our API returns an array of project repos,
   so in our request we will use Json.Decoder.list RepoInfo
   to extract a List RepoInfo from the JSON.
-}


repoInfoListDecoder : Json.Decoder (List RepoInfo)
repoInfoListDecoder =
    Json.list repoInfoDecoder



--get the data: the second parameter of Http.get is the URL of the request


fetchData : Cmd Msg
fetchData =
    Http.get repoInfoListDecoder "https://api.github.com/users/rootscript/repos"
        |> Task.mapError toString
        |> Task.perform ErrorOccurred DataFetched



-- UPDATE
--To begin we define 4 actions:
--use Msg to describe what our app can do, and respond to


type
    Msg
    --the NoOp action does nothing
    = NoOp
    | FetchData
    | ErrorOccurred String
    | DataFetched (List RepoInfo)



--define an update function (that takes Msg and Model, and updates the Model (messagePlaceholder) & Cmd Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        FetchData ->
            --update the model with fetchData function
            { model | messagePlaceholder = "Initiating data fetch!" } ! [ fetchData ]

        ErrorOccurred errorMessage ->
            --update the model messagePlaceholder with any error
            { model | messagePlaceholder = "Oops! An error occurred: " ++ errorMessage } ! []

        DataFetched repoList ->
            --update the model repoList and messagePlaceholder
            { model | repoList = repoList, messagePlaceholder = "The data has been fetched!" } ! []



-- VIEW


view : Model -> Html Msg
view model =
    let
        showRepo repo =
            ul [ class "style-list" ]
                [ li []
                    [ text ("| Repo ID: " ++ (toString repo.id) ++ "; ")
                    , text (" | Repo Username: " ++ repo.name)
                    , text (" | Repo full_name: " ++ repo.full_name)
                    ]
                ]
    in
        div []
            [ div [] [ text model.messagePlaceholder ]
            , button [ onClick FetchData ] [ text "Click to load rootscript's repositories" ]
            , ul [] (List.map showRepo model.repoList)
            ]
