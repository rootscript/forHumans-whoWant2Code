#-elm-forHumans - day 03
### forHumans-whoWant2Code

[![Join the chat at https://gitter.im/rootscript/forHumans-whoWant2Code](https://badges.gitter.im/rootscript/forHumans-whoWant2Code.svg)](https://gitter.im/rootscript/forHumans-whoWant2Code?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This is a part 03 of a diary of a new user trying to learn the Elm language.  Part 01 was a draft of an article `-elm-forHumans` for the medium.com series called `forHumans() => {whoWant2Code}`

The main project aim is to help ordinary people who want to create/code their own applications that use web technologies, to create their own native applications & not just 'traditional' web pages trapped in a a current version of Chrome, Safari, or Firefox; and able to access local files etc... with fewer browser based restrictions.

The second aim of the project is to encourage people who are learning Elm, to contribute back to the project, and provide them the means & structure to do that.

###Where did today go? Feel some Elm love !

I didn't look at a single line of Elm code today, I dived into the Elm-lang Slack channel for beginners, and found it a little different to most of the coding places.  The first point to note, is that there is a dedicated channel called beginners (Wow, we are of value & have our own channel).  

Secondly, everyone is fairly chatty - It felt a little like going out for a drink after work, and being introduced to friends of friends.  I was pleasantly surprised that my thoughts about what I'd like to do with Elm were not mocked or looked at being a silly dream.  Lastly, you get the theme here, everyone was super friendly, and I felt I could ask whatever was on my mind, without having to justify whether it was a valid question that was worthy of a reply.

I asked the question if anyone was interested in getting Elm to work with Electron, and found there were a few who were interested, and a few willing to give some guidance ( without having to beg for help ).  It seems like my basic idea of just using `elm-make` to compile `Main.elm` to `index.js`, and then `require` the .js file into the `index.html` was the same basic integration that others were looking at too ( That was encouraging ).
What surprised me was that there was also an `electron` channel in the elm-lang Slack group.  I was kindly directed there and told that there was an `elm-electron` interop set of modules that had been worked on, this would expose the Electron API to Elm through `ports`, so that Elm could talk '*directly*' (through a port) to the Electron `screen` module etc...
...to be continued

I left a few questions in the electron channel, I was warned it might be quiet ( I had the pleasure of being the 3rd post ever in the channel, we will need to encourage some more magnetism ! )

---

###Useful resources that to help learn the current 0.17 version of Elm

Ok so this is day 03, and despite not having learnt anything major on day 01 or 02, I'm still here and found some useful resources.  One of the subjects discussed in the elm-lang beginners Slack channel was where to find a list of depreciated Elm modules.

About 50% of the tutorials and articles I found googling turned out to be for older versions than the current 0.17 version of Elm.  If you are new to Elm, this could get to be a source of frustration as you will be unsure as to why things don't work, and as all Elm code looks like 'alien' to newcomers, most won't be able to spot depreciated modules or changes in syntax ( without some guidance ).

So here area few links that are really worth reading, so you can spot 'old Elm code', and either avoid or try updating it to 0.17 code:

A Farewell to FRP - <http://elm-lang.org/blog/farewell-to-frp>

Upgrading to 0.17 - <https://github.com/elm-lang/elm-platform/blob/master/upgrade-docs/0.17.md>

Elm 0.17: Successful Upgrade of Real World App …and some soft of guide to all of this - <https://medium.com/@turbo_MaCk/elm-0-17-successful-upgrade-of-real-world-app-and-some-soft-of-guide-to-all-of-this-cafd59dec56f#.pthtw81gy>

Here is what I wrote a few days ago, on the subject:

*For me, the biggest issue is finding quality learning resources that WORK with the current version of Elm 0.17. I think if a language had a manifesto it should include that all training videos, tutorial articles, language documentation etc... have the version of Elm stamped on every page, and every code file has a comment with the Elm version number. People pick up various fragments of code from many places, and when things don't work due to this problem, even the best resources become a reason to give up or avoid learning further.*

After today I feel a little better ( now I will have a chance ), maybe there could even be a list of links to outdated tutorials whether written, in Github repos, or Youtube videos, and volunteers could have a go at upgrading them to the latest version of Elm, and crossing them off the list of elm resources to avoid?

---

###Losing everything I know, and learning 'Alien speak', I mean Elm - part 2.

Today I had a mixed set of feelings, 'a little blushed' & and 'a little proud'.  My 2 months of accelerated learning to code was commended, as was the 20 years someone had spent coding, as were various other lengths of time in between.  I felt comfortable that there was also another person in the discussion who had also only done 2 days of learning Elm.  The interesting part was that someone mentioned that because I didn't have much experience with other programming languages, that it might be a benefit, as I wouldn't have predefined views on 'how things are done'.

In my reality, I was finding it very tough, to leave the endless libraries of 'one thing well' node modules & little ES6 techniques that I had built into my little toolbox of knowledge.  Taking the step towards Elm, felt like someone ripping away my gold medal, let me explain:

I do have 8 weeks of trying to learn JavaScript under my belt ( I know that is a short time ), but I felt that I have had some success, I can create desktop apps that can pull data from the web, I can load/save read/write to my local files, I can control windows and other OS native stuff, I have Electron Render & Main processes talking to each other - I am quite happy with my 2 months progress in Electron, ES6 and various node_modules.

Knowing how happy I am with my own progress, helps me to understand the pain, that came across in the discussions with other Elm learners.  If I was in pain after a 2 month life of coding, how would you feel after 20 years of object oriented, or imperative coding.  To all of us Elm code looks like alien speak, in that I felt a sense solidarity.

###*Places to chat with people about Elm*

Yesterday I wrote about my apprehension of talking in the elm-lang Slack channel, but despite having moments when I've been frowned on in other 'coding communities' I took the plunge, said what I wanted to say, and found a welcoming group of human beings.  That was nice!  I can fully recommend joining the beginners channel:

[**Go to the Elm Slack channel**](http://elmlang.herokuapp.com/)

---

###break time :o)

Ok so today I did nothing in Elm, but felt good just chatting with people about Elm.  I also came to the conclusion, that despite all Elm's strengths, that it might not **yet** fit into my idea of my perfect coding language.

I'm uneasy at how Elm talks with JavaScript libraries & node_modules.  You could just rewrite all the good node_modules in Elm ( but that isn't realistic ), or you could find a way to to talk with external APIs.  The issue being do you want to do that through a tiny hole while holding a pair of chopsticks?  This may need some attention.

There is a very well written guide, that gave me some hope, it's here:

<https://guide.elm-lang.org/interop/javascript.html>

I would love it to be backed up with some examples that **focus** on this with some well known node_modules, and maybe a dedicated place to go, where you could find integration work that had been done before, or at least find a guide as to how ( if you had the Elm & node skills ) you might author an Elm helper module exposing a node_module API.

---

###Electron & Elm specific resources

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
 
###End of day 3 - trying to get started with Elm