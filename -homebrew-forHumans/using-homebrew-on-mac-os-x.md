# using homebrew on Mac OS X

### forHumans() => {whoWant2Code}   [![Join the chat at https://gitter.im/rootscript/forHumans-whoWant2Code](https://badges.gitter.im/rootscript/forHumans-whoWant2Code.svg)](https://gitter.im/rootscript/forHumans-whoWant2Code?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Homebrew is a package manager for Mac OS X that installs apps and libraries etc… It is like the Mac App Store for coders and people who like free open source applications.

Using Homebrew you can install, uninstall, and update to the latest versions of whatever you choose for it to manage. To get a full list of things that you have installed you can type: **_brew list_** in your terminal

Here are a couple of homebrew commands that I use that Iuse in Terminal on my Mac, and might forget to use:

```bash
#Any line starting with the symbol # is a comment to help explain the command below it.

#Use this command to list anything that's installed that has a new version to update to.
brew outdated

#Here I can update all outdated items.
brew upgrade `brew outdated`

#Here I check for updates to Homebrew itself.
brew update

#Here I check for any problems with Homebrew.
brew doctor
```

<script src="https://gist.github.com/rootscript/4d16516b14fc2a1dd7be188cda668839.js"></script>

Really all I’m looking for are the magic words : “Your system is ready to brew”, which means that there are no errors & I’m ready to install something new, and evrerything is updated to the lastest versions.

You can also search for things to install using:

```
brew search whateverYouAreLookingFor
```

This is the first draft, and the start of a series of articles that aims to help ordinary people who want to create/code their own applications.

This article is published to medium.com here: [using homebrew on Mac OS X](https://medium.com/@rootscript/using-homebrew-on-mac-os-x-d4f19667b3#.b8od7gw67)

---

####To be updated

//TODO::maybe — add screen recording, save it to YouTube, or make an animated gif

//TODO::needed — add footnotes to install homebrew, and how to start the terminal app (remember this is to help people, assume they know nothing)

//TODO::bestPractise — select 2 example apps to install (always try to show 2 examples so that people can see similarities)

[**rootscript/forHumans-whoWant2Code**  
_forHumans-whoWant2Code - This is the start of a series of articles for medium.com called forHumans() => {whoWant2Code}_github.com](https://medium.com/r/?url=https%3A%2F%2Fgithub.com%2Frootscript%2FforHumans-whoWant2Code "https://github.com/rootscript/forHumans-whoWant2Code")[](https://github.com/rootscript/forHumans-whoWant2Code)

[**rootscript/forHumans-whoWant2Code**  
_Where ordinary people can chat & leave message about this project._gitter.im](https://medium.com/r/?url=https%3A%2F%2Fgitter.im%2Frootscript%2FforHumans-whoWant2Code%3Futm_source%3Dbadge%26utm_medium%3Dbadge%26utm_campaign%3Dpr-badge%26utm_content%3Dbadge "https://gitter.im/rootscript/forHumans-whoWant2Code?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge")[](https://gitter.im/rootscript/forHumans-whoWant2Code?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
