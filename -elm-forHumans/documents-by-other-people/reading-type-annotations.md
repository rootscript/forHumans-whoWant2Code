#How to Read a Type Annotation

Link to the original, thoughtfully written document <https://github.com/elm-guides/elm-for-js>

If you come from a dynamically typed language like JavaScript or Ruby, or even a statically typed C-family language like
Java, Elm's type annotations will look very strange. However, once you know how to read them, they make a lot more sense
than `int strcmp(const char *s1, const char *s2);`. That's a good thing, because type annotations aren't for the
compiler (it has type inference and can figure things out) but for you, the programmer.

The most important reason to know about type annotations when you're starting out is that the docs for every function
in the standard library have them. The annotation tells you how many arguments a function takes, what their types are,
what order to pass them, and what the return type is. This information is not repeated elsewhere.

Once you know how to read an annotation, it's fairly easy to write them. Doing so is is optional, but highly encouraged.
Type annotations improve code by helping you think about what the function should be doing, and serve as
compiler-verified documentation. (You know how an out-of-date comment is worse than no comment at all? Well, type
annotations never get out of date.) In addition, if you ever want to publish a third-party library, you will need type
annotations.

## Definitions

The first thing to know is that `:` means "has type".

```elm
answer : Int
answer = 42
```

You can read "answer has type Int; answer equals forty-two".

Common primitive types include `Int`, `Float`, `Bool`, and `String`. You can also pair up types into tuples, for example
`(Int, Bool)`. This expands to arbitrarily many elements, i.e. `(Int, Float, Int)` is a 3-tuple with first element `Int`,
second `Float`, third `Int`.

```elm
myTuple : (String, Int, Bool)
myTuple = ("the answer", 42, True)
```

In case you haven't noticed yet, types always begin with a capital letter (or open paren).

There's one special type with only one value of that type. Both the type and value are read as "unit" and written as
`()`. Unit is often used as a placeholder value, since if we know the type, we can anticipate the value.

## Functions

`->` is used to separate the arguments and return value in the types of functions. It's pronounced "goes to". So for
example, `String.length : String -> Int` is pronounced "string-dot-length has type String goes to Int". You just read
left to right, like an English sentence. Oh and by the way, `String.length` means the `length` function in the `String`
module. Whenever a capital letter is followed by a dot, it's a module, not a type.

Things get interesting with multiple arrows, for example, `update : Action -> Model -> Model`. This function takes an
Action and a Model as arguments (in that order), and returns a Model. Or, "update has type Action goes to Model goes to
Model."

What's really going on is that the type annotation is telling you about *partial application*: you can give a function
only some of its arguments, and get a function as a result. You can always get the new function's type annotation by
covering up part of the left side of the original function's annotation.

```elm
example : Model -> Model
example = update someAction
```

There are implied parentheses in the annotation, so we could also write: `update : Action -> (Model -> Model)`.

You probably don't need to worry about partial application, also known as currying, too much at first. Just think of the
type after the last arrow as the return value, and the others as the arguments to your function.

## Higher Order Functions

Like JavaScript, functions can take other functions as arguments. (We've already seen how currying lets them return
functions.)

Let's look at a specialized version of the `List.map` function, which takes a function, and applies it to every element
of a list of Float, returning a new list of Int as a result.

```elm
specialMap : (Float -> Int) -> List Float -> List Int
```

The first argument of this function needs to be a function, that takes a Float as a parameter and returns an Int. When
you read this annotation, it may help to say "Float goes to Int" a little bit faster, and then pause. Here, the brackets
*do* matter. This is different than `Int -> Float -> List Int -> List Float`, which takes two numbers and a
list, but never a function.

We know that `round : Float -> Int`, so we can write:

```elm
roundMap : List Float -> List Int
roundMap = specialMap round
```

Even though `roundMap` doesn't take any arguments explicitly to the left of the equals, applying `specialMap` returns a
function thanks to currying. We could also write `roundMap xs = specialMap round xs`; it's really a matter of style.

## Type Variables

If you look at the List library, this isn't actually how
[List.map](http://package.elm-lang.org/packages/elm-lang/core/latest/List#map) is defined. Instead, it has lowercase
type names, which are *type variables*:

```elm
List.map : (a -> b) -> List a -> List b
```

This means that the function works for any types `a` and `b`, as long as we've fixed their values, which usually happens
by passing arguments whose types we know. So we could give it a `(Float -> Int)` and a `List Float`, or we could give a
`(String -> Action)` and a `List String`, and so on. (This use of "variable" is closer to algebra than JavaScript, in
that it's something you or the compiler find based on constraints, not explicitly set to whatever you need it to be.)

By convention, type variables are single letters starting at the beginning of the alphabet, although (almost) any
lowercase string will work. Occasionally it's helpful to use another letter or a descriptive word, especially if you
have more than one type variable. For example, `Dict k v` reminds us that the types variables are the keys and values.
It's possible for a type to have any number of type variables, but more than two is rare.

Type variables let us write generic code, like lists and other containers that can hold any type of value. Each
particular container can only hold one type, but you get to pick what that is.  Then `List.map` can traverse a list and
apply a function to it, without knowing what's in the list. Only the function applied to each element needs to know what
type those elements are.

If `List a` is a list of any type, what is just `List`? Technically it's called a *type constructor*, but the better
answer is that it's not really anything. It can't really exist on its own. The best way to think of it is that `List a`
is the base type, and sometimes the type variable `a` gets replaced with a real type.

## Records

A record is like a JS object, except you know at compile-time that the fields you access will be there. Also like
JavaScript, they're written with brackets. *Unlike* JavaScript, records values use equals between key and value; when
written with colons, it's a record *type*. Here's a simple record:

```elm
point : {x : Float, y : Float}
point = {x = 3.2, y = 2.5}
```

In most cases that's all you need to know about record types. But it's also possible to write functions that work on
records as long as they have the right fields, ignoring any other fields.

```elm
planarDistance : {a | x : Float, y : Float} -> {b | x : Float, y : Float} -> Float
planarDistance p1 p2 =
  let dx = p2.x - p1.x
      dy = p2.y - p1.y
  in sqrt (dx^2 + dy^2)
```

The `{a |` part of the annotation indicates a base record, of type `a`, is extended. Then we list the fields it's
extended with, and what their types are. In the simplest cast, `a` can be the empty record, i.e. there are no extra
fields. We use a different type variable, `b`, for the second argument to indicate that the two records don't have to be
the same type. For example:

```elm
point3D = {x = 1.0, y = 6.3, z = -0.9}

dist = planarDistance point point3D
```

## Constrained types

Elm has three special type variables that indicate that the value needs to one of a few different types, but not just
any type.

A `number` is either an `Int` or `Float`. A number literal without a decimal point is a `number`. Numbers support
basic arithmetic (except division, which is handled separately for each type).

A `comparable` can be a number, character, string, or recursively a list or tuple of comparables. Surprisingly enough,
comparables can be compared with operations like `(>)`. Elm's dictionaries and sets are implemented as binary search
trees, so the keys or elements must be comparable.

An `appendable` can be a string, text (i.e. with typesetting information), or a list (containing any type). Two
appendables of the same type can be appended with `(++)`.

To use any of these types, just use their name in an annotation instead of a specific type or type variable.

If one of these types appears multiple times in a type annotation, all occurrences must resolve to the same type. You
can allow them to be different by sticking something on to the end of the type, like `appendable2` or similar. For
example, if you enter `(4, 2)` into the Elm REPL, it will infer the type `(number, number')`. The apostrophe indicates
that the second number need not be the same type as the first.
