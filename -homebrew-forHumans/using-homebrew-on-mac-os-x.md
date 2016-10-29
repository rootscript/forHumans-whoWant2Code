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

Sometimes when you run `brew doctor`, it might warn you that your version of Xcode is out of date, and advise you to update it from the Mac App Store.  After you do this you should type the following to get Xcode command line tools installed too ( as you might find that /usr/local/git does not work, until you agree to the popup license agree, found when install the Xcode command line tools ):

```
xcode-select --install
```

This is the first draft, and the start of a series of articles that aims to help ordinary people who want to create/code their own applications.

---

[**rootscript/forHumans-whoWant2Code**  
_Where ordinary people can chat & leave message about this project._gitter.im](https://medium.com/r/?url=https%3A%2F%2Fgitter.im%2Frootscript%2FforHumans-whoWant2Code%3Futm_source%3Dbadge%26utm_medium%3Dbadge%26utm_campaign%3Dpr-badge%26utm_content%3Dbadge "https://gitter.im/rootscript/forHumans-whoWant2Code?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge")[](https://gitter.im/rootscript/forHumans-whoWant2Code?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)


