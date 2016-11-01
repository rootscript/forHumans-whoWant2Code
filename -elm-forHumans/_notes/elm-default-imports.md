# Elm Core Libraries - Default Imports

Every Elm project needs the core libraries. They provide basic functionality including:

*   The Basics — addition, subtraction, etc.
*   Data Structures — lists, dictionaries, sets, etc.

## Default Imports

In all Elm files there is a small set of default imports:

```
import Basics exposing (..)
import Debug
import List exposing ( List, (::) )
import Maybe exposing ( Maybe( Just, Nothing ) )
import Result exposing ( Result( Ok, Err ) )
import Platform exposing ( Program )
import Platform.Cmd exposing ( Cmd, (!) )
import Platform.Sub exposing ( Sub )
```
The intention is to include things that are both extremely useful and very unlikely to overlap with anything that anyone will ever write in a library. By keeping the set of default imports small, it also becomes easier to use whatever version of `map` suits your fancy. Finally, it makes it easier to figure out where the heck a function is coming from.

<http://package.elm-lang.org/packages/elm-lang/core/latest>

---

*   [Array](/packages/elm-lang/core/4.0.5/Array)*   [Basics](/packages/elm-lang/core/4.0.5/Basics)*   [Bitwise](/packages/elm-lang/core/4.0.5/Bitwise)*   [Char](/packages/elm-lang/core/4.0.5/Char)*   [Color](/packages/elm-lang/core/4.0.5/Color)*   [Date](/packages/elm-lang/core/4.0.5/Date)*   [Debug](/packages/elm-lang/core/4.0.5/Debug)*   [Dict](/packages/elm-lang/core/4.0.5/Dict)*   [Json.Decode](/packages/elm-lang/core/4.0.5/Json-Decode)*   [Json.Encode](/packages/elm-lang/core/4.0.5/Json-Encode)*   [List](/packages/elm-lang/core/4.0.5/List)*   [Maybe](/packages/elm-lang/core/4.0.5/Maybe)*   [Platform](/packages/elm-lang/core/4.0.5/Platform)*   [Platform.Cmd](/packages/elm-lang/core/4.0.5/Platform-Cmd)*   [Platform.Sub](/packages/elm-lang/core/4.0.5/Platform-Sub)*   [Process](/packages/elm-lang/core/4.0.5/Process)*   [Random](/packages/elm-lang/core/4.0.5/Random)*   [Regex](/packages/elm-lang/core/4.0.5/Regex)*   [Result](/packages/elm-lang/core/4.0.5/Result)*   [Set](/packages/elm-lang/core/4.0.5/Set)*   [String](/packages/elm-lang/core/4.0.5/String)*   [Task](/packages/elm-lang/core/4.0.5/Task)*   [Time](/packages/elm-lang/core/4.0.5/Time)

---

