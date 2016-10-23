module Elm_Module.IsOnline exposing (..)

{-| IsOnline functions and Msg.
# Model
@docs Model, initialModel, init
# Message
@docs Msg, Status
# Update function
@docs update
# View function
@docs view
# Common Helpers
@docs setRandomHost, getTime
# Static data
@docs hosts
# Custom Events
@docs onLoad
-}

-- elm 0.17.1

import Html exposing (Html, text, img)
import Html.App as App
import Html.Events exposing (on)
import Html.Attributes exposing (style, src)
import Json.Decode as Decode exposing ((:=))
import Task
import Random
import Array
import Time exposing (Time)


{-| Model
-}
type alias Model =
    { online : Status
    , host : Maybe String
    , now : Maybe Time
    }


{-| Online Status type
-}
type Status
    = Online Bool
    | Offline


{-| Initial model
-}
initialModel : Model
initialModel =
    { online = Offline
    , host = Nothing
    , now = Nothing
    }


{-| initialise the model
-}
init : ( Model, Cmd Msg )
init =
    ( initialModel
    , Cmd.none
    )


{-| A union type representing The Elm Architect's `Msg`
-}
type Msg
    = Onload
    | SetHost Int
    | SetTime (Maybe Time)


{-| The Elm Architect's update function.
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Onload ->
            ( { model | online = Online True }, Cmd.none )

        SetHost num ->
            let
                arr =
                    Array.fromList hosts

                host =
                    case Array.get num arr of
                        Nothing ->
                            ""

                        Just x ->
                            x
            in
                ( { model | host = Just host }, getTime )

        SetTime time ->
            ( { model | now = time }, Cmd.none )


{-| Check we have the `host` & `time` & render an image
-}
view : Model -> Html Msg
view model =
    let
        timestamp =
            case model.now of
                Nothing ->
                    ""

                Just time ->
                    toString time
    in
        case model.host of
            Nothing ->
                Html.text ""

            Just host ->
                img
                    [ style [ ( "display", "none" ) ]
                    , src ("http://" ++ host ++ "/favicon.ico?" ++ timestamp)
                    , onLoad Onload
                    ]
                    []


{-| Capture image load event.
-}
onLoad : msg -> Html.Attribute msg
onLoad msg =
    on "load" (Decode.succeed msg)


{-| One or more hosts to check.
-}
hosts : List String
hosts =
    [ "www.google.com"
    , "www.cloudflare.com"
    , "www.baidu.com"
    , "www.yandex.ru"
    ]


{-| Generate a random Int for us to pluck a host out of the list of strings.
-}
setRandomHost : Cmd Msg
setRandomHost =
    Random.generate SetHost (Random.int 0 (List.length hosts - 1))


{-| Get and Set the current time for image cache busting
-}
getTime : Cmd Msg
getTime =
    Task.perform (always (SetTime Nothing)) (Just >> SetTime) Time.now
