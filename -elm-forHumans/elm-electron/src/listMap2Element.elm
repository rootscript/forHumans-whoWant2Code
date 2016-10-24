--elm 0.17.1
{-| Apply a function to every element of a list.
    use a list of items to specify text property on html elements using List.map
-}
--


module Main exposing (..)

import Html exposing (Html, button, div, li, text, ul)
import Html.App as Html
import Mouse exposing (..)
import String exposing (dropLeft, dropRight, toInt)
import Array exposing (Array, fromList, get)
import Regex exposing (replace, regex, Match, Regex)


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    List String


model : Model
model =
    [ "Hello"
    , "World"
    , "third-item"
    , "fourth"
    ]



-- TODO:: add example loading list from Json & readline from txt


type Msg
    = None


update msg model =
    model



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ ul []
            --            (List.map (\m -> li [] [ text m ]) model)
            (List.map (\m -> button [] [ text m ]) model)
        ]
