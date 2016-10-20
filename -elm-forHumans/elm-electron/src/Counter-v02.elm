module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.App as App
import Html.Events exposing (onClick)


main =
    App.beginnerProgram { model = 0, view = view, update = update }



-- Model


type alias Model =
    Int



--model : Model
--model =
--  0
-- Update


type Msg
    = Increment
    | Decrement
    | Increment2


update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

        Increment2 ->
            model + 2



-- View


view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick Increment2 ] [ text "++" ]
        ]
