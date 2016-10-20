-- LINKtoDOCS :: https://guide.elm-lang.org/architecture/
import Html exposing (..)


-- MODEL — the state of your application

type alias Model = { ... }


-- UPDATE — a way to update your state

type Msg = Reset | ...

update : Msg -> Model -> Model
update msg model =
  case msg of
    Reset -> ...
    ...


-- VIEW — a way to view your state as HTML

view : Model -> Html Msg
view model =
  ...