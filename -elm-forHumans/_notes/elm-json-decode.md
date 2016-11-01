#Decode a List of Numbers From a JSON String in Elm 
<video width="720" height="480" controls>
    <source src="https://embedwistia-a.akamaihd.net/deliveries/eaf3e5b99f73e46a0cb3c64b143ddf85d7a47c87/file.mp4" type="video/mp4">
</video>

Decoding JSON strings in Elm is a 2-step process:

Create a "recipe" for the decoding
Perform the decoding

This lesson gives a couple basic examples of the two steps in action.

```
import Html exposing (text)
import Json.Decode exposing (Decoder, decodeString)

-- Define a "recipe" (decoder)
-- Execute the recipe (decoder)

-- Result x a = Err x | Ok a

num = "4"
nums = "[1,2,3,4,5,6,7]"

numbersDecoder : Decoder (List Int)
numbersDecoder = list int

decoded : Result String (List Int)
decoded = decodeString numbersDecoder nums

main = text (toString decoded)

```

<https://egghead.io/lessons/elm-decode-a-list-of-numbers-from-a-json-string-in-elm>

