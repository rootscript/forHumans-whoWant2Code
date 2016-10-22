--elm 0.17.1


module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.App as App
import Html.Events exposing (onClick)


-- Our main function


main =
    App.beginnerProgram { model = 0, view = view, update = update }



-- Model of our data structures, describing the type of data


type alias Model =
    Int



-- Messages that lists/name which functions will be used to create new values from our Model data


type Msg
    = Increment
    | Decrement
    | Increment2



-- Update Function ( takes in a Message, our data Model, & returns other data Models )
-- it contains functions that are used in response to each Message case


update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

        Increment2 ->
            model + 2



-- View Function ( takes in a the new data Model, & returns html, using functions implemented in our Update Function to interact with our Viewed Model data )
-- div & button are functions from our imported Html package
-- onClick is a function imported from Html.Events, that allows the buttons to start functions from an onClick event


view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick Increment2 ] [ text "++++" ]
        ]
