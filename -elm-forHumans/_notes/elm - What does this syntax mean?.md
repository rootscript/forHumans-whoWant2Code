The exclamation point in `model ! []` is just a short-hand function for `(model, Cmd.batch [])`, which is the type returned from typical `update` statements. [It is defined here](http://package.elm-lang.org/packages/elm-lang/core/4.0.1/Platform-Cmd#!)

You can use the Elm Packages Fancy Search (Go to [Elm Packages](http://package.elm-lang.org/) and click on [Fancy Search](http://klaftertief.github.io/elm-search/)) to find functions like that. If you search on `!` it will show the correct function `Platform.Cmd`


<iframe width="720" height="600" src="http://klaftertief.github.io/elm-search/" frameborder="0">
</iframe>

