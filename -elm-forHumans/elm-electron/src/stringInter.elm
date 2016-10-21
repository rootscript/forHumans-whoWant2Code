--elm 0.17.1


module Main exposing (..)

import Html exposing (Html, text, div)
import Html.App as Html
import Mouse exposing (..)
import String exposing (dropLeft, dropRight, toInt)
import Array exposing (Array, fromList, get)
import Regex exposing (replace, regex, Match, Regex)


{-| Inject other strings into a string in the order they appear in a List
  interpolate "{0} {2} {1}" ["hello", "!!", "world"]
  "{0} {2} {1}" `interpolate` ["hello", "!!", "world"]
-}
interpolate : String -> List String -> String
interpolate string args =
    let
        asArray =
            fromList args
    in
        replace Regex.All interpolationRegex (applyInterpolation asArray) string


interpolationRegex : Regex
interpolationRegex =
    regex "\\{\\d+\\}"


applyInterpolation : Array String -> Match -> String
applyInterpolation replacements match =
    let
        ordinalString =
            ((dropLeft 1) << (dropRight 1)) match.match

        ordinal =
            toInt ordinalString
    in
        case ordinal of
            Err message ->
                ""

            Ok value ->
                case get value replacements of
                    Nothing ->
                        ""

                    Just replacement ->
                        replacement


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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Mouse.moves (\{ x, y } -> Position x y)



-- VIEW


output : String
output =
    interpolate "My order is {0} {2} {1}" [ "one", "two", "there" ]


view : Model -> Html a
view model =
    Html.text output
