# What are subscriptions?
A subscription is a way for a component to sit around and wait for messages. You can subscribe to the current time. You can subscribe to location changes. You can subscribe to web socket messages. Etc.

The simplest subscription is time. It is the basis of this SVG clock:

<iframe src="http://elm-lang.org/examples/time" style="display: block; width: 720px; height: 300px; margin: 0px auto; border: none;"></iframe>

Look at the following definition:

```
subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every second Tick
```
Based on the current model, we are describing all the active subscriptions. In this case, the [`Time.every`](http://package.elm-lang.org/packages/elm-lang/core/4.0.0/Time#every) function is setting up a subscription to the current time, updated every second. New times (like `Tick 1462487781991`) are fed into the `update` function, just like messages resulting from mouse clicks or HTTP requests.

---

