[Source][1]

### Question by [kayne][2]

**1** votes.

I copied this code so anyone can try it out [http://elm-lang.org/try][3]

    import Html exposing (..)
    import Html.App as App
    import Html.Attributes exposing (..)
    import Html.Events exposing (..)

    main =
      App.program
      { init = init
      , view = view
      , update = update
      , subscriptions = _ -> Sub.none
      }

    init =
      ( { posts = [], newPost = { title = "", slug = "" } }, Cmd.none )

    type alias Post =
      { title : String
      , slug : String
      }

    type alias Model =
      { posts : List Post
      , newPost : Post
      }

    type Msg
      = NoOp
      | NewPostField Post String String

    update msg model =
      case msg of

        NoOp ->
          ( model, Cmd.none )

        NewPostField currentPost field newValue ->
          case field of

            "title" ->
              ( { model | newPost = { slug = currentPost.slug, title = newValue } }, Cmd.none )

            "slug" ->
              ( { model | newPost = { slug = newValue, title = currentPost.title } }, Cmd.none )

           -- The problem is here, I have to repeat this process for every field

            _ ->
              ( model, Cmd.none )

    view model =
      div []
        [ h1 [] [ text ("title : " ++ model.newPost.title ++ " | slug : " ++ model.newPost.slug) ]
        , input [ onInput (NewPostField model.newPost "title"), placeholder "Title" ] []
        , input [ onInput (NewPostField model.newPost "slug"), placeholder "Slug" ] []
        , button [] [ text "Save" ]
      ]

I minimized the fields to two (title and slug), but there are others like : content, excerpt...

Is there is anyway I can update the record without creating a case for all the fields, something like updating only the field necessary without going through all of them ?

[1]: http://stackoverflow.com/questions/40163994/elm-updating-fields-dynamically-in-elm
[2]: http://stackoverflow.com/users/5935358/kayne
[3]: http://stackoverflow.com/try

---

[Source][1]

### Answer by [mariosangiorgio][2] ✓

**4** votes.

I would change the following thing in your code:

If you have a specific message for each action you can have much cleaner `update` and `view` functions. The compiler will also help you checking that you handle all the cases and that you don't pass a meaningless argument.

    type Msg
      = NoOp
      | NewPostTitle Post String
      | NewPostSlug Post String

This doesn't save you too much typing, but your `update` will look like this. Note that you don't have nested pattern matching anymore. Also, note the syntax for [updating records][3], one field at a time.

    update msg model =
      case msg of
        NoOp ->
          ( model, Cmd.none )
        NewPostTitle currentPost value ->
          ( { model | newPost = { currentPost | title = value } }, Cmd.none )
        NewPostSlug currentPost value ->
          ( { model | newPost = { currentPost | slug = value } }, Cmd.none )

Finally, in your view you won't have to pass the string parameter, which makes the code a bit more concise. But the real important part is that now it's type-safe.

    view model =
      div []
        [ h1 [] [ text ("title : " ++ model.newPost.title ++ " | slug : " ++ model.newPost.slug) ]
        , input [ onInput (NewPostTitle model.newPost), placeholder "Title" ] []
        , input [ onInput (NewPostSlug model.newPost), placeholder "Slug" ] []
        , button [] [ text "Save" ]
      ]

##### Comments

* Yes I did this at first, I'm looking for more efficient way, rather than a function update for every field, (I have some models who does have more than 12 fields) [[kayne][4]]
* I like this answer as Elm record is a static type. If I want to have something dynamic, then I would use `Dict` or something. [[Tosh][5]]
* Thanks guys, I think this is the way in Elm, writing too much, I'll stick with it [[kayne][4]]

[1]: http://stackoverflow.com/questions/40163994/elm-updating-fields-dynamically-in-elm
[2]: http://stackoverflow.com/users/353268/mariosangiorgio
[3]: http://stackoverflow.com/docs/records#updating-records
[4]: /users/5935358/kayne
[5]: /users/1238847/tosh

---

```
import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
  App.program
  { init = init
  , view = view
  , update = update
  , subscriptions = \_ -> Sub.none
  }


init =
  ( { posts = [], newPost = { title = "", slug = "" } }, Cmd.none )


type alias Post =
  { title : String
  , slug : String
  }


type alias Model =
  { posts : List Post
  , newPost : Post
  }


type Msg
  = NoOp
  | NewPostTitle Post String
  | NewPostSlug Post String

update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )
    NewPostTitle currentPost value ->
      ( { model | newPost = { currentPost | title = value } }, Cmd.none )
    NewPostSlug currentPost value ->
      ( { model | newPost = { currentPost | slug = value } }, Cmd.none )

view model =
  div []
    [ h1 [] [ text ("title : " ++ model.newPost.title ++ " | slug : " ++ model.newPost.slug) ]
    , input [ onInput (NewPostTitle model.newPost), placeholder "Title" ] []
    , input [ onInput (NewPostSlug model.newPost), placeholder "Slug" ] []
    , button [] [ text "Save" ]
  ]
```