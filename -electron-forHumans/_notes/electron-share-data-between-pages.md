#Electron Tips
##How to share data between web pages?

To share data between web pages (the renderer processes) the simplest way is to use HTML5 APIs which are already available in browsers. Good candidates are [Storage API](https://developer.mozilla.org/en-US/docs/Web/API/Storage), [`localStorage`](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage), [`sessionStorage`](https://developer.mozilla.org/en-US/docs/Web/API/Window/sessionStorage), and [IndexedDB](https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API).

Or you can use the IPC system, which is specific to Electron, to store objects in the main process as a global variable, and then to access them from the renderers through the remote property of electron module:

```
// In the main process.
global.sharedObject = {
  someProperty: 'default value'
}
```
```
// In page 1.
require('electron').remote.getGlobal('sharedObject').someProperty = 'new value'
```
```
// In page 2.
console.log(require('electron').remote.getGlobal('sharedObject').someProperty)
```
---
##My app's window/tray disappeared after a few minutes.

This happens when the variable which is used to store the window/tray gets garbage collected.

If you encounter this problem, the following articles may prove helpful:

*   [Memory Management](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Memory_Management)
*   [Variable Scope](https://msdn.microsoft.com/library/bzt2dkta(v=vs.94).aspx)

If you want a quick fix, you can make the variables global by changing your code from this:

```
const {app, Tray} = require('electron')
app.on('ready', () => {
  const tray = new Tray('/path/to/icon.png')
  tray.setTitle('hello world')
})
```
to this:

```
const {app, Tray} = require('electron')
let tray = null
app.on('ready', () => {
  tray = new Tray('/path/to/icon.png')
  tray.setTitle('hello world')
})
```
---
These were plucked from the Electron FAQ <https://github.com/electron/electron/blob/v1.4.4/docs/faq.md>




