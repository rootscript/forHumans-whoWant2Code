# Elm and JavaScript

##basics
Embedding Elm in a JavaScript project is three lines of JS

First compile the .js file from the .elm file:

```
elm-make Main.elm --output main.js
```
then add these lines to your index.html

```
<div id="main"></div>
<script src="main.js"></script>
<script>
  var node = document.getElementById('main');
  var app = Elm.Main.embed(node);.
</script>
```

---
##ports
Communicating between JavaScript and Elm can be achieved in two ways: via ports and via flags. Getting Elm & JavaScript to communicate requires a couple of adaptions on both sides.

 - define a port module `port module Counter exposing (..)`
 - adding ports for listening to JS, and sending from JS.
 
 ```
 port check : Int -> Cmd msg
port counter : (Int -> msg) -> Sub msg
 ```
 
Every communication between Elm and JavaScript runs through port, where we can interact via commands and subscriptions. In the above example we send data to the JS side through the check port. We now have the option to send an integer by calling `check 1`
 
 The subscription part is covered by the counter port. We’re subscribing to any changes to the counter value coming from the JS side.
 
 We can now initialize the counter f.e. In this very specific case we define an initial counter value of 3 and then subscribe to any changes on that counter.
 
 ```
 <script>
    var node = document.getElementById('counter');
    var app = Elm.Counter.embed(node);
    app.ports.counter.send(3)
    app.ports.check.subscribe(function(count) {
        console.log('receiving data...', count);
    })
</script>
 ```
 
We could also listen to changes and multiply the current count by 3 f.e.

```
<script>
    // ...
    app.ports.check.subscribe(function(count) {
        app.ports.counter.send((count*3))
    })
</script>
```

---
##ports example
###question: Using ports to send Elm values to a JS library - plot a graph (stackoverflow)

I would like to use the flot.js 2D plot library from elm. I first thought I'd write a native wrapper for it but it seems to be discouraged. I therefore want to try to use ports to send the values to plot to JavaScript (ie the call to flot.js would be made on the JavaScript side). Is this possible?
###answer:
Yes, you can use ports to send data from Elm to plot into a Flot graph. Here's a rewrite of the [Basic Flot Example](http://www.flotcharts.org/flot/examples/basic-usage/index.html) using Elm as the data source.

```
port flotExample1 : List (List (Maybe (List Float)))
port flotExample1 =
  let
    halfStepsTo14 =
      List.map (\x -> x / 2) [0..28]
    d1 =
      List.map (\x -> Just [x, sin x]) halfStepsTo14
    d2 =
      List.map Just [[0, 3], [4, 8], [8, 5], [9, 13]]
    d3 =
      [Just [0, 12], Just [7, 12], Nothing, Just [7, 2.5], Just [12, 2.5]]
  in
    [ d1, d2, d3 ]
```

Elm will do the conversion of basic Elm datatypes in ports to Javascript types on the other side. The `Maybe` in the function signature above is to account for the fact that nulls can be used to separate line segments in Flot (see example `d3`)

```
<script>
        var app = Elm.worker(Elm.Main);

        $(function() {
            $.plot("#placeholder", app.ports.flotExample1);
        });
</script>
```
You can make more complex examples like accessing a server URL from Elm or tying into other Signals like Time or mouse movements (in which case your port signature will be a `Signal (List (List (Maybe (List Float))))`), but it will still all revolve around ports.

<http://stackoverflow.com/questions/34626245/use-ports-for-rendering-in-elm>

---
##flags
###question: Reading global JavaScript variable from Elm (stackoverflow)

I'm currently building a small component of a web app in Elm. The elm component is compiled to a JavaScript file, loaded and then mounted on a DOM node. It should then read a config object from window.config. (This is not something I can change.)

How can I e.g. read a string from window.config.title to use in my Elm component? I've looked at ports, but it seems to require me to modify the generated JavaScript or wrap something around it. Is that the only option? If so, how would I simply read the value of a variable?
###answer:
If your configuration does not change over the lifetime of your app, you will probably be best served by using [Html.App.programWithFlags](http://package.elm-lang.org/packages/elm-lang/html/latest/Html-App#programWithFlags).

This allows for your `main` function to accept a single value from Javascript during initialization. That single value can be a simple javascript object or it can even contain nested properties. The important thing is defining its shape inside Elm.

Let's say your javascript configuration looks like this:

```
<script>
  window.options = {
    foo: 123,
    nested: { bar: "abc" }
  };
</script>
```

In order to be able to pass that into your Elm file, you can define a matching shape like this:

```
type alias Flags =
  { foo : Int
  , nested : { bar : String }
  }
```

Now you can use `programWithFlags` in your Elm file like this, defining an `init` function that takes `Flags` as an argument:

```
import Html exposing (..)
import Html.App as Html
import Platform.Cmd exposing (..)
import String

main =
  Html.programWithFlags
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

init : Flags -> (Model, Cmd Msg)
init flags =
  { introText = String.concat
    [ "foo is "
    , toString flags.foo
    , " and nested.bar is "
    , flags.nested.bar
    ]
  } ! []
```

The last piece of the puzzle is to pass your Javascript configuration option to Elm during initialization. Your html and javascript should look something like this (the relevant portion is in passing `window.options` as the second parameter of `embed()`):

```
<body>
  <div id="myContainer"></div>
  <script src="Main.js"></script>
  <script>
    var myContainer = document.getElementById("myContainer");
    var app = Elm.Main.embed(myContainer, window.options);
  </script>
</body>
```
<http://stackoverflow.com/questions/37979211/reading-global-javascript-variable-from-elm>

---

###related questions
How to coordinate rendering with port interactions (Elm 0.17)
<http://stackoverflow.com/questions/38952724/how-to-coordinate-rendering-with-port-interactions-elm-0-17>


