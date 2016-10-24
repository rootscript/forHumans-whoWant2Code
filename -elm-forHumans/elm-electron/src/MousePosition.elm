--elm 0.17.1


module Main exposing (..)

import Html exposing (Html, text, div)
import Html.App as Html
import Mouse exposing (..)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { xAxis : Int
    , yAxis : Int
    }


initialModel : Model
initialModel =
    { xAxis = 0
    , yAxis = 0
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- UPDATE


type Msg
    = Position Int Int


update : Msg -> Model -> ( Model, Cmd a )
update msg model =
    case msg of
        Position x y ->
            ( { model | xAxis = x, yAxis = y }, Cmd.none )



{- update msg model =
   case msg of
       Position x y ->
           ( { model | xAxis =  toFloat (model.xAxis - x) / 2, yAxis = toFloat (model.yAxis - y) / toFloat 2}, Cmd.none )
-}
-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Mouse.moves (\{ x, y } -> Position x y)



-- VIEW


view : Model -> Html a
view model =
    Html.text (toString model)
