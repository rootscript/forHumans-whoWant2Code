# Using ports to deal with files in Elm 0.17

Written by [Tolga Paksoy](https://github.com/tolgap)  
on <time datetime="2016-08-12T15:58:03Z">August 12, 2016</time>

## Introduction

Implementing file upload in Elm is not straightforward. The language has no support for files or blobs yet. A proposition to add it to Elm 0.18 is [in the talks](https://groups.google.com/forum/#!topic/elm-dev/u66_K3AbqIM). But it is still unsure if it will make the cut for 0.18 or whether it will be pushed back another release. Until then, a Javascript implementation is necessary.

Javascript has an API for reading files embedded to input fields; the [`FileReader` api](https://developer.mozilla.org/nl/docs/Web/API/FileReader). It is even supported by IE10, so no need to worry about older browsers/IE. In this post, we will create a simple form input that will read an image from an input field, and display the image preview. The`FileReader` API will be used in a Javascript port to read files `base64` encoded, and pass it back to our Elm runtime for displaying.

## Asking the file from Javascript

Lets look at the port implementation first. This is where the Elm application is initialized, and the Javascript interop behavior is defined. For more information about ports, see [this Elm guide page](http://guide.elm-lang.org/interop/javascript.html) first.

First, we setup our Elm code with the necessary `Msg` for asking back file information from Javascript:

    import Ports exposing (ImagePortData, fileSelected, fileContentRead)

    type Msg
      = ImageSelected
      | ImageRead ImagePortData

Next up, we define the necessary ports inside a seperate port module. This module also includes the `ImagePortData` type alias:

    port module Ports exposing (..)

    type alias ImagePortData =
      { contents : String
      , filename : String
      }

    port fileSelected : String -> Cmd msg

    port fileContentRead : (ImagePortData -> msg) -> Sub msg

We now have two port functions we can use for our file upload scenario. `fileSelected` is for calling the Javascript interop, and `fileContentRead` is the receiving function.

## Specifying the port behavior

So far, we've modeled our Elm behavior for reading file data. Next up, we define the Javascript ports for communicating back to our Elm runtime with the necessary file data.

Lets define `fileSelected`'s behavior. This port is called when the file `input` field changes. It receives the `input` field id as the argument. If the id does not exist, it skips execution. Inside of `fileSelected`, we use the second port `fileContentRead` to send the necessary file information back to our Elm application. Note that the object we build has the exact same structure as `ImagePortData` in the Elm application.

    var app = Elm.Main.fullscreen();

    app.ports.fileSelected.subscribe(function (id) {
      var node = document.getElementById(id);
      if (node === null) {
        return;
      }

      // If your file upload field allows multiple files, you might
      // want to consider turning this into a `for` loop.
      var file = node.files[0];
      var reader = new FileReader();

      // FileReader API is event based. Once a file is selected
      // it fires events. We hook into the `onload` event for our reader.
      reader.onload = (function(event) {
        // The event carries the `target`. The `target` is the file
        // that was selected. The result is base64 encoded contents of the file.
        var base64encoded = event.target.result;
        // We build up the `ImagePortData` object here that will be passed to our Elm
        // runtime through the `fileContentRead` subscription.
        var portData = {
          contents: base64encoded,
          filename: file.name
        };

        // We call the `fileContentRead` port with the file data
        // which will be sent to our Elm runtime via Subscriptions.
        app.ports.fileContentRead.send(portData);
      });

      // Connect our FileReader with the file that was selected in our `input` node.
      reader.readAsDataURL(file);
    });

## A sample application

Here's a quick sample application to show a file input field with preview functionality. Once a file gets selected (assuming we only allow images), we display an `img` with the `src` attribute set to the `base64` encoded result from the `FileReader` API.

    -- Main.elm
    module Main exposing (..)

    import Html exposing (..)
    import Html.App exposing (program)
    import Html.Attributes exposing (src, title, class, id, type')
    import Html.Events exposing (on)
    import Json.Decode as JD
    import Ports exposing (ImagePortData, fileSelected, fileContentRead)

    type Msg
      = ImageSelected
      | ImageRead ImagePortData

    type alias Image =
      { contents : String
      , filename : String
      }

    type alias Model =
      { id : String
      , mImage : Maybe Image
      }

    main : Program Never
    main =
      program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }

    init : ( Model, Cmd Msg )
    init =
      ( { id = "ImageInputId"
        , mImage = Nothing
        }
      , Cmd.none
      )

    update : Msg -> Model -> ( Model, Cmd Msg )
    update msg model =
      case msg of
        ImageSelected ->
          ( model
          , fileSelected model.id
          )
        ImageRead data ->
          let
            newImage =
              { contents = data.contents
              , filename = data.filename
              }
          in
            ( { model | mImage = Just newImage }
            , Cmd.none
            )

    view : Model -> Html Msg
    view model =
      let
        imagePreview =
          case model.mImage of
            Just i ->
              viewImagePreview i
            Nothing ->
              text ""
      in
        div [ class "imageWrapper" ]
          [ input
            [ type' "file"
            , id model.id
            , on "change"
              (JD.succeed ImageSelected)
            ]
            []
          , imagePreview
          ]

    viewImagePreview : Image -> Html Msg
    viewImagePreview image =
      img
        [ src image.contents
        , title image.filename
        ]
        []

    subscriptions : Model -> Sub Msg
    subscriptions model =
     fileContentRead ImageRead

    -- Ports.elm
    port module Ports exposing (..)

    type alias ImagePortData =
      { contents : String
      , filename : String
      }

    port fileSelected : String -> Cmd msg

    port fileContentRead : (ImagePortData -> msg) -> Sub msg

And now, create an `index.html` file with the necessary boilerplate to initialise our Elm application called `Main`:

    <!DOCTYPE HTML>
    <html>
    <head>
      <meta charset="UTF-8">
      <title>Main</title>
    </head>

    <body>
      <script type="text/javascript" src="elm.js">
      </script>
      <script type="text/javascript">
        var app = Elm.Main.fullscreen();

        /* add the contents of the ports example above here
           app.ports etc...
         */
      </script>
    </body>
    </html>

Now compile your Elm code to Javascript and start up the Elm reactor using the following commands:

    $ elm make Main.elm --output=elm.js
    Success! Compiled 1 module.
    Successfully generated elm.js

    $ elm reactor
    elm-reactor 0.17.1
    Listening on http://localhost:8000/

Next up, go to [http://localhost:8000](http://localhost:8000) using your browser and choose "index.html" from the files list. The file input will be served. If you pick an image, the `FileReader` API will return the contents of it and the Elm application will display your chosen image below the input field.

## Conclusion

In this tutorial, we have seen how easy the Elm interop with Javascript is. The APIs that are not available in Elm yet, can be "worked around" using ports. You define the ports, define the `Msg` that will be used with the ports, define the Javascript of these ports and you're ready to go.