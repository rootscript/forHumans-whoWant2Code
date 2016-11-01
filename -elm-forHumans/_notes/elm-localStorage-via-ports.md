# elm 0.17 - How to persist some user data in the browser

There is no official support for it in the latest elm (by this time it is 0.17), but you can simply do it via ports. This is a working example (based on an example from the offical docs) of using localStorage via ports for elm 0.17

##Main.elm

```
port module Main exposing (..)

import Html exposing (Html, button, div, text, br)
import Html.App as App
import Html.Events exposing (onClick)
import String exposing (toInt)

main : Program Never
main = App.program
  {
    init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

type alias Model = Int

init : (Model, Cmd Msg)
init = (0, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = load Load

type Msg = Increment | Decrement | Save | Doload | Load String

port save : String -> Cmd msg
port load : (String -> msg) -> Sub msg
port doload : () -> Cmd msg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
      Increment ->
        ( model + 1, Cmd.none )
      Decrement ->
        ( model - 1, Cmd.none )
      Save ->
        ( model, save (toString model) )
      Doload ->
        ( model, doload () )
Load value ->
        case toInt value of
          Err msg ->
            ( 0, Cmd.none )
          Ok val ->
            ( val, Cmd.none )

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick Increment ] [ text "+" ]
    , br [] []
    , button [ onClick Save ] [ text "save" ]
    , br [] []
    , button [ onClick Doload ] [ text "load" ]
    ]
```

##index.html


```
<!DOCTYPE HTML>
<html>
<head>
  <meta charset="UTF-8">
  <script type="text/javascript" src="js/elm.js"></script>
</head>
<body>
</body>
<script type="text/javascript">
    var storageKey = "token";
    var app = Elm.Main.fullscreen();
    app.ports.save.subscribe(function(value) {
      localStorage.setItem(storageKey, value);
    });
    app.ports.doload.subscribe(function() {
      app.ports.load.send(localStorage.getItem(storageKey));
    });
</script>
</html>
```
Now, by pressing buttons +/- you change the int value. When you press "save" button, the app stores the actual value into localStorage (by "token" key). Then try to refresh the page and press "load" button - it takes the value back from localStorage (you should see the HTML text control actualized with the restored value).

<http://stackoverflow.com/questions/33697444/data-persistance-in-elm>

---
## the official elm-lang package ( *in progress* )

<https://github.com/elm-lang/persistent-cache/issues>
NOT RELEASED YET — I hope to release it relatively soon, but I cannot make any promises. Until then, please use ports if you want to use localStorage.

### Cache Data in Browser - localStorage

Cache values in a user’s browser. If the user closes your site and comes back tomorrow, the cached data will still be there.

> **Note:** This library is built on JavaScript’s [`localStorage`](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage) API. As of this writing, that means you get about 5mb of space. This space is the total for your whole domain, so you cannot have two 5mb caches. Users can also clear all this storage in their browser settings, so it is not 100% reliable. All this is why we treat it like a cache in Elm!

---


