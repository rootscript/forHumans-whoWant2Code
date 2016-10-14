#-elm-forHumans - day 04
### forHumans-whoWant2Code

[![Join the chat at https://gitter.im/rootscript/forHumans-whoWant2Code](https://badges.gitter.im/rootscript/forHumans-whoWant2Code.svg)](https://gitter.im/rootscript/forHumans-whoWant2Code?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This is a part 04 of a diary of a new user trying to learn the Elm language.  Part 01 was a draft of an article `-elm-forHumans` for the medium.com series called `forHumans() => {whoWant2Code}`

The main project aim is to help ordinary people who want to create/code their own applications that use web technologies, to create their own native applications & not just 'traditional' web pages trapped in a a current version of Chrome, Safari, or Firefox; but able to access local files, interact with the system OS, etc... with fewer browser based restrictions.

The second aim of the project is to encourage people who are learning Elm, to contribute back to the project, and provide them the means & structure to do that.  One thing that usually is hard to discover, is how to setup your code editor of choice to syntax highlight, code complete, display documents etc... and specifically with Elm, to use elm-format, elm-make, elm-reactor.  Finally how to get the latest docset for the Elm language and be able to view them locally & offline.

I started trying to get Webstorm setup, but got sidetracked on the idea that if I also collated everything I could for Atom, LightTable, and Visual Studio Code, it would be a nice single place to come to get your environment setup, but also a nice place to come and contribute any further tips.
I think it would be best to have a section in the Repo, which gets published with Github pages.

###Using Elm in Jetbrains Webstorm

I didn't look at a single line of Elm code today again!, I have just been thinking/tinkering about setting up my development environment.   We all have our favourite code editors that we have become familiar with & have customised yo our liking.  In the past I have tried using Sublime, Atom, and Visual Studio code.  My preference is for Webstorm, but as Elm isn't mainstream yet, customising it towards the Elm language isn't well documented.

Today I'm going to document my Webstorm setup for Elm 0.17

####elm-plugin

Elm language plugin for IntelliJ IDEA ( Webstorm ) with these features:

*   Supports Elm 0.17.0
*   Parsing the syntax
*   Syntax highlighting and color settings page
*   Going to declaration
*   Highlighting unresolved references with a quick-fix option to add an import statement
*   Code completion
*   Spellchecking
*   Brace matching
*   Rename refactoring

Formatting is currently not a feature of the plugin, but the `elm-format` plugin can be used instead.

####elm-format

This is for WebStorm and other JetBrains IDEs.

1.  Install elm-format
2.  Install the [Elm Language Plugin](https://durkiewicz.github.io/elm-plugin/) package.
3.  Add a file watcher for .elm files with the settings as [shown here](/avh4/elm-format/blob/master/img/JetBrains%20setup.png).

####elm-make

I'm trying to setup a File Watcher in Webstorm to convert .elm files to javascript. I have the node_module elm installed, but I cannot find any docs with examples.

Currently I use Terminal to run a script in my project directory:

`node ./deploy.js` which runs this script:

```
const copydir = require("copy-dir");
const eol = require("os").EOL;
const exec = require("child_process").execSync;
const pkg_json = require("./package.json");
const APP_DIR = `${__dirname}/app`;
const BUILD_DIR = `${__dirname}/build`;
// copy ./app/* to ./build/*
copydir.sync(APP_DIR, BUILD_DIR);
// run the "elm:build" npm script.
try {
exec(pkg_json.scripts["elm:build"]);
console.log("Deploy succeeded!");
} catch (err) {
console.error("Deploy *FAILED* during 'elm:build'!");
console.error(eol);
console.error("Error log from command:");
console.error(eol);
console.error(err);
}
```

`elm:build` is setup in my `package.json` file as:


```
"elm:build": "node ./node_modules/elm/binwrappers/elm make ./src/Main.elm --output ./build/index.js"
```

I would like to use the Webstorm file watcher to do this.



full path to node.js interpreter should be specified as a `Program`,

`Arguments` set to `./node_modules/elm/binwrappers/elm make $FilePathRelativeToProjectRoot$ --output ./build/index.js`
 
`Working directory` set to `$ProjectFileDir$`
  
`Output paths to refresh` set to `$ProjectFileDir$/build/index.js`
   
And you have to make sure that your file watcher is listening to changes in .elm files only
- you have to either set up the corresponding custom file type in `( Preferences | Editor | File Types )` and choose this type as your watcher file type,
- or set file type to `any`, configure the custom scope `( Preferences | Appearance & Behavior | Scopes )` with only .elm file included and choose this scope as the file watcher scope

...to be continued

####elm-reactor

####elm-oracle

`elm-oracle` can be run in the Terminal to query information about an .elm file.  You can install it using `npm` (the node package manager) like so: `npm install -g elm-oracle`

This might be useful to someone:

`elm-oracle Main.elm Html.text | jq`

I use `| jq` to pipe the output from elm-oracle to something human readable


```
[
  {
    "name": "text",
    "fullName": "Html.text",
    "href": "http://package.elm-lang.org/packages/elm-lang/html/latest/Html#text",
    "signature": "String -> Html.Html msg",
    "comment": " Just put plain text in the DOM. It will escape the string so that it appears\nexactly as you specify.\n\n      text \"Hello World!\"\n"
  },
  {
    "name": "textarea",
    "fullName": "Html.textarea",
    "href": "http://package.elm-lang.org/packages/elm-lang/html/latest/Html#textarea",
    "signature": "List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg",
    "comment": " Represents a multiline text edit control. "
  }
]
```
You probably will need to install js ( it isn't that well known, but is VERY useful ):
`npm install jq`

---

###Using Elm in Atom

in progress.

---

###Using Elm in LightTable

in progress.

---

###Using Elm in Visual Studio Code

in progress.

//TODO:: add links back to any Github repo's issues, so that users can contribute back to the source of any plugins etc...

---
### Elm Language documentation

Lastly, lets recap on anything common to all, like the Elm language documentation.

Docsets for Elm that can be used with Dash (OS X) and Zeal (Windows & Linux) can be downloaded from here: <http://newyork.kapeli.com/feeds/zzz/user_contributed/build/Elm/Elm.tgz>

On Mac OS X (yes I am using a build for OS X) the docket can be unpacked here `/Users/yourUserName/Library/Application Support/Zeal/Zeal/docsets`


---

###Useful resources for the current 0.17 version of Elm

Side project idea - I was looking for a JSON url feed for http://package.elm-lang.org/
Basically I'm trying to get a list of all the elm packages, descriptions, links etc...
& get notified when one of my Elm project's packages could be updated.

<http://package.elm-lang.org/all-packages>

<http://package.elm-lang.org/new-packages>


```
[
    {
        "name": "Apanatshka/elm-list-ndet",
        "summary": "Nondeterministic values / cartesian combinable lists",
        "versions": [
            "1.0.1",
            "1.0.0"
        ]
    },
    {
        "name": "Bogdanp/elm-datepicker",
        "summary": "A reusable date picker component",
        "versions": [
            "3.0.1",
            "3.0.0",
            "2.0.0",
            "1.0.2",
            "1.0.1",
            "1.0.0"
        ]
    },
]
```

Maybe could do something like `elm-package diff elm-lang/core 3.0.0 4.0.0`

I could even do this part in node exec child process ???

just jotting down some thoughts,


---

###Losing everything I know, and learning 'Alien speak', I mean Elm.

Sometimes I think about things too much, running before I can walk, looking at advanced topics before I can do a 'Hello World!', it's in my nature to look ahead at the difficult parts and get some perspective, so that I can learn to walk while going towards the right direction.  I've always had an instinct to go towards trouble, I'm not sure why? When it comes to coding all that realistically means is that I can put a few sentences together that sound like I might know what I'm doing, get my feet a little wet, but never hope to produce a best of class solution at this moment in time.

I need progress, not perfection.  Perfection will come if I do my best to make make progress.

###*Places to chat with people about Elm*

Yesterday I wrote about my apprehension of talking in the elm-lang Slack channel, but despite having moments when I've been frowned on in other 'coding communities' I took the plunge, said what I wanted to say, and found a welcoming group of human beings.  That was nice!  I can fully recommend joining the beginners channel:

[**Go to the Elm Slack channel**](http://elmlang.herokuapp.com/)

Here are some other places that I find interesting as there are discussions as to where the Elm language is going:

[**Go to Elm Discuss on Google Groups**](https://groups.google.com/forum/#!forum/elm-discuss) - This list exists to discuss anything Elm related, from beginner questions to compiler design.

[**Go to Elm Dev on Google Groups**](https://groups.google.com/forum/#!forum/elm-dev) - This list is for work on Elm, not design discussion or Q&A with devs.

And elm reddit:
https://www.reddit.com/r/elm/

---

###break time :o) 

Yesterday I jotted down some thoughts about Elm integration with JS:  I came to the conclusion, that despite all Elm's strengths, that it might not **yet** fit into my idea of my perfect coding language, because on our dependency on things we like or are useful in JavaScript.

*I'm uneasy at how Elm talks with JavaScript libraries & node_modules.  You could just rewrite all the good node_modules in Elm ( but that isn't realistic ), or you could find a way to to talk with external APIs.  The issue being do you want to do that through a tiny hole while holding a pair of chopsticks?  This may need some attention.*

*There is a very well written guide, that gave me some hope, it's here*:

<https://guide.elm-lang.org/interop/javascript.html>

*I would love it to be backed up with some examples that **focus** on this with some small, but well known node_modules, and maybe a dedicated place to go, where you could find integration work that had been done before, or at least find a guide as to how ( if you had the Elm & node skills ) you might author an Elm helper module exposing a node_module API.*

**UPDATE day04** Well I might as well start making a list of useful JS libs that could be used in Elm:

- elm-moment - <https://github.com/NoRedInk/elm-moment> A Moment port to Elm

Not for production usage, simply a place for documenting the things we want from moment

- Task ports - <https://groups.google.com/forum/#!topic/elm-discuss/TjWoacZobWw> Just a discussion which may not lead to anything.

- FileReader - <https://www.paramander.com/blog/using-ports-to-deal-with-files-in-elm-0-17> a recent article with example .elm & .js files.

Implementing file upload in Elm is not straightforward. The language has no support for files or blobs yet. A proposition to add it to Elm 0.18 is in the talks. But it is still unsure if it will make the cut for 0.18 or whether it will be pushed back another release. Until then, a Javascript implementation is necessary.

Javascript has an API for reading files embedded to input fields; the FileReader api. It is even supported by IE10, so no need to worry about older browsers/IE. In this post, we will create a simple form input that will read an image from an input field, and display the image preview. TheFileReader API will be used in a Javascript port to read files base64 encoded, and pass it back to our Elm runtime for displaying.



---

###Electron & Elm specific resources

I managed to get this Elm 0.17 example working in Electron 1.41:

<https://medium.com/@zenitram.oiram/a-beginners-guide-to-json-and-elm-c4a0c7e20002#.fhm48t172>

###Other resources ( very useful link )

Stumbled across a nice `awesome-list` for Elm ( if you have never come across an `awesome-list` before on Github, they are a **curated**  list of recommend resources ). Here is `awesome-elm` as recommended by Richard Feldman <https://github.com/rtfeldman/awesome-elm>

###So what is next?
* ~~document my attempt to start learning Elm.~~ started
* ~~document my struggle to get Electron & Elm working together.~~ started
* ~~create an Elm Electron starter project, with good comments.~~ started
* document getting Elm to work with various node_modules.
* give feedback to the Elm guys, that will help them lower the barriers to learning the Elm language.
* write articles for medium.com to encourage others to learn Elm.
* add setup files with instructions to many examples to a Github repository.
* ~~create a Gitter channel that encourages new starters, and takes them on the journey of learning Elm, and  that encourages them to give feedback, create more examples, components, and tutorials that help Elm grow.~~ done, but not publicised, & maybe not needed as Slack is so friendly.  The only issue with Slack is the 10,000 message limit, and lack of archiving.  Bitter seems better to me, as you can look back on the archives day by day, and month to month.
* document other areas useful to getting started with Elm such as Homebrew, Npm, Node, and Electron.
* create a different kind of YouTube series, where people learning Elm teach others what they have learned.

//TODO:: list articles that are on medium
//TODO:: list planned articles for the forHumans 'platform'

* -electron-forHumans
* -elm-forHumans
* -github-forHumans
* -homebrew-forHumans
* -npm-forHumans
 
###End of day 4 - trying to get started with Elm