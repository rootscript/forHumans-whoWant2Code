#-elm-forHumans - day 02
### forHumans-whoWant2Code

[![Join the chat at https://gitter.im/rootscript/forHumans-whoWant2Code](https://badges.gitter.im/rootscript/forHumans-whoWant2Code.svg)](https://gitter.im/rootscript/forHumans-whoWant2Code?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This is a part 02 of a diary of a new user trying to learn the Elm language.  Part 01 was a draft of an article `-elm-forHumans` for the medium.com series called `forHumans() => {whoWant2Code}`

The main project aim is to help ordinary people who want to create/code their own applications that use web technologies, to create their own native applications & not just 'traditional' web pages.

The second project aim is to encourage people who are learning Elm, to contribute back to the project, and provide them the means & structure to do that.

The Electron framework	is a key part of what I think is a very nice platform for learning, that is current & will produce useable applications.  I've been looking at the other key parts, and believe that Functional Programming & Reactive techniques are the next step in making great useable desktop apps, that leverage all the advances in web technology.

---

###Useful resources that I've found that will help learn Elm

Ok so this is day 02, and despite not having learnt anything major on day 01, I'm still here and want to plan what and where to find the next steps.   I'd like to create a list of resources as I find them, and give my first honest impressions as to whether I think they will be useful.

I've recently discovered medium.com and find a great comfort to find people that appear to have made similar decisions about the direction they want top go in.  Here is one such article 'After React: Elm?' link the article here: <https://medium.com/wraptime-io/after-react-elm-152bd6559cb1#.y4iezavkr> which pretty much describes how I felt.   Here is an extract:

"*So you’ve mastered React, Redux, ES6, etc and you find yourself in a better position than a couple of years ago; now you’ve got a more maintainable source code with unidirectional data flow, fast DOM manipulation with Virtual DOM and other nice perks such as (HMR) Hot Module Reload. Not bad! But it’s never enough in the world of software development, is it? We still have to suffer from*:

 - *Javascript fatigue: You need at least 10 different libraries to get started on a react project. And those libraries change over time. Our typical project has around 20–40 dependencies*.
 - *A language unfit for purpose: Javascript lets you do things that you shouldn’t (99% of the time), like mutating object values.*"
 
I found this to be a timely and greatly encouraging article, that makes me feel that I've started to learn to code at just the right time; the last 2 months I've been playing with ES6, RxJS, Ractive, doing lots of reading about every framework I can. If I hadn't taken the first step towards Elm, I would still be ES6 land, learning RxJS and hoping to move to other pieces of the puzzle like Mori.js for immutatble goodness from Clojure, Cycle.js as different way of looking at interaction, Ramda.js for being full of curry & functional style (amongst others), BUT always in my mind was a guiding light saying "avoid Angular & React, they too cemented in the current & unable to change quickly without upsetting their large user bases, don't follow the crowd!".

###Losing everything I know, and taking the plunge into Elm.

Despite my short life as a coder, it has been relatively easy for me to find the shortest path to success, experimenting along the way, has led to to Elm.  I could see Elm as something to head towards, I just thought that it was a language for extreme experts who were living very close to the edge, but were so comfortable in their own abilities, that they could do anything.
The second hardest part for me, is throwing away all the applications that I've written over the last two months in Electron & ES6 (I will be keeping the Electron parts, but rewriting all the other parts in Elm; that is if I'm good enough, presently I can't even manage an Elm Hello World!).

Well now i'm on my way, after 2 months of learning Javascript, testing frameworks, and looking for a solution going forward, I've decided on a solution that makes sense & is worth investing time in learning.  Maybe I'm cleverer than I give myself credit for, analysing the state of play, going functional & immutable now seems like a sensible decision.  I am just lucky that I haven't had years of JavaScript under my belt, clouding & holding my ability to judge the current state of coding.

There are still a few things in the JavaScript world that interest me, where time allows I would like to take a look at Folktale.js in order to try and get to the maths (despite my small brain)

###*Places to chat with people about Elm*
That article on medium.com, by Freeman Latin also mentions:

[**Go to the Elm Slack channel**](http://elmlang.herokuapp.com/): "*There’s a lively community that’s very helpful to beginners and everyone else, and being a strongly typed functional language, full of seasoned developers. Ask questions and in my experience someone will help within 5 minutes.*"

I'm not sure if I'm ready for 'talking to people yet', I've always felt that in coding communities, you have to justify your existence and intentions, and the quality of your questions is important; which I agree with to some extent, but find it is restrictive.

Maybe once I feel a little more comfortable, I'd like to go somewhere only populated by Elm newbies, policed occasionally by some elder Elm folk.   We'll see how that goes, the 'beginners' channel in Slack Elm seems like a good place to watch for a while, until I get a voice :o)

before I forget, the author of that medium.com article (Freeman Latif) says that he is in the process of writing a book called “Elm for React Developers”.  Will log it here & keep an eye out for it.

 ---

Here is a very relevant talk which touches on the subject of growing a community - link to article & video here <http://www.elmbark.com/2016/03/16/mainstream-elm-user-focused-design> 

For me, the biggest issue is finding quality learning resources that WORK with the current version of Elm 0.17.  I think if a language had a manifesto it should include that all training videos, tutorial articles, language documentation etc... have the version of Elm stamped on every page, and every code file has a comment with the Elm version number.  People pick up various fragments of code from many places, and when things don't work due to this problem, even the best resources become a reason to give up or avoid learning further.

---

###break time :o)
Ok, so that's the first half of today out the way, time for dinner, & I'll resume reading up on Elm tonight (and add more to this document)

Here are a few podcasts, that put Elm in some human context ( sometimes it is good to hear people talk, without them being in 'conference mode' ):

[218: Elm with Evan Czaplicki and Richard Feldman](https://changelog.com/218/)

[191: Elm and Functional Programming with Richard Feldman](https://changelog.com/191/)

One of the things that had bothered me over my last 2 months of trying to become a coder, was that I could get things to work without fully understanding what I was dealing with.  Looking at this statement, and qualifying it further, I should say that JavaScript & Electron allowed me to fiddle and produce desktop apps that worked, and looked like the ideas I had dreamt of creating.  However those applications were patched together from hundreds of attempts with different frameworks & node_modules, and lots of self learning trial & error.

The npm ecosystem which seemed to encourage small modules that did 'one thing well', seemed like an interesting path for me to choose.  The reality was that although I found some useful modules, I was constantly looking for another module, that did something better or cleaner, the choice of node_modules is bewildering, and I was never certain if there was some better way of doing what I wanted.

The fact that without a great deal of knowledge, I could make JavaScript applications that worked, was encouraging at the time, but now I want to look at the longterm, and I really wonder what I could build if I invest sometime into making apps that work as well as possible.  That is really exciting, and I think that Elm is the way to go.

---

###Another medium article - let's get it working in Elm Electron

<https://medium.com/@zenitram.oiram/a-beginners-guide-to-json-and-elm-c4a0c7e20002#.fhm48t172>

###So what is next?
* document my attempt to start learning Elm.
* document my struggle to get Electron & Elm working together.
* create an Elm Electron starter project, with good comments.
* document getting Elm to work with various node_modules.
* give feedback to the Elm guys, that will help them lower the barriers to learning the Elm language.
* write articles for medium.com to encourage others to learn Elm.
* add setup files with instructions to many examples to a Github repository.
* create a Gitter channel that encourages new starters, and takes them on the journey of learning Elm, and  that encourages them to give feedback, create more examples, components, and tutorials that help Elm grow.
* document other areas useful to getting started with Elm such as Homebrew, Npm, Node, and Electron.
* create a different kind of YouTube series, where people learning Elm teach others what they have learned.

//TODO:: list articles that are on medium
//TODO:: list planned articles for the forHumans 'platform'

* -electron-forHumans
* -elm-forHumans
* -github-forHumans
* -homebrew-forHumans
* -npm-forHumans
 
###End of day 1 - trying to get started with Elm