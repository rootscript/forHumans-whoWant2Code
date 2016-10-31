#Debug Electron App with VSCode
2016-09-18
<http://code.matsu.io/1>

Here is a guide to debugging Electron App with VSCode. It works on all platforms, and includes instruction for debugging both Main and Renderer process.

I’ll be using [electron/electron-quick-start](https://github.com/electron/electron-quick-start). Clone and open the project in VSCode. Then go to the Debug Viewlet and click the configure icon to make an empty `launch.json`.

## Main Process

Fill `launch.json` with the following.

```
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug Main Process",
      "type": "node",
      "request": "launch",
      "cwd": "${workspaceRoot}",
      "runtimeExecutable": "${workspaceRoot}/node_modules/.bin/electron",
      // Use the following for Windows
      // "runtimeExecutable": "${workspaceRoot}/node_modules/.bin/electron.cmd",
      "program": "${workspaceRoot}/main.js"
    }
  ]
}
```
The setting is pretty self-explanatory, use the `electron` in `node_modules` to run `main.js`. If you go to the Debug Viewlet and run `Debug Main Process`, you should see the code stopping at the breakpoints in `main.js`.

![](media/14778733477821.png)


## Renderer Process

Making Renderer process work involves more effort, but as most of Electron App’s code lives in Renderer Process, it is of more interest.

First, a high-level explanation as to how we’ll make it work. Electron has a launch flag `--remote-debugging-port`, which lets you specify a port for remote debugging. The language spoken at this port is [Chrome Debugging Protocol](https://developer.chrome.com/devtools/docs/debugger-protocol), and VSCode has an extension that just handles that: [Debugger for Chrome](https://marketplace.visualstudio.com/items/msjsdiag.debugger-for-chrome).

### Setting up

#### Go to `main.js` and comment out this line:

    mainWindow.webContents.openDevTools()

Remote debugging doesn’t work with multiple DevTools clients. We’ll use the debugger in VSCode instead of Electron’s DevTools.

#### Install Debugger for Chrome

Launch Quick Open, and enter `ext install debugger-for-chrome`.

#### Add a new configuration in `launch.json`

    {
      "version": "0.2.0",
      "configurations": [
        {
          "name": "Debug Renderer Process",
          "type": "chrome",
          "request": "launch",
          "runtimeExecutable": "${workspaceRoot}/node_modules/.bin/electron",
          // Use the following for Windows
          // "runtimeExecutable": "${workspaceRoot}/node_modules/.bin/electron.cmd",
          "runtimeArgs": [
            "${workspaceRoot}/main.js",
            "--remote-debugging-port=9222"
          ],
          "webRoot": "${workspaceRoot}"
        }
      ]
    }

Most of the configuration is straightforward. 9222 is the port Debugger for Chrome uses by default, and `webRoot` tells Debugger for Chrome the location of the source code that we want to debug for.

#### Add some code to `renderer.js`

    console.log('hello world!')

    document.body.addEventListener('click', () => {
      console.log('hello vscode!')
    })

Now we are ready to go.

### Debugging

I added two breakpoints in `renderer.js`, and ran `Debug Renderer Process` in the Debug Viewlet.

![](media/14778734080526.png)

Electron will stop on the second breakpoint if I click anywhere in the window:

![](media/14778734285576.png)

However, it wouldn’t hit the first breakpoint. The reason is Debugger for Chrome would first launch Electron, and try to attach to the running process to debug it. When it successfully attached itself, the first `console.log` had already been executed.

The solution is to go to the Electron window and press `cmd+r` to reload, Electron will re-execute the renderer and hit the breakpoint.

![](media/14778734738819.png)


### Transpiling

Most modern Web apps are written in languages that transpile to JavaScript. If sourcemaps are generated during transpilation, we can debug the original code in VSCode.

I modified [electron/electron-quick-start](https://github.com/electron/electron-quick-start) to use Babel and Webpack to transpile ES6 code. Here I’m debugging the un-transpiled code:

![](media/14778734927737.png)
Details are in this commit: [4bb4a93](https://github.com/octref/vscode-electron-debug/commit/4bb4a93)

## Why all the hassle?

You get all the nice features in VSCode while debugging, like:

*   [Go to Definition](https://code.visualstudio.com/docs/editor/editingevolved#_go-to-definition)
*   [Peek definition](https://code.visualstudio.com/docs/editor/editingevolved#_peek)
*   Use Vim commands to jump around, thanks to [VSCodeVim](http://aka.ms/vscodevim)
*   Code folding

When inspecting DOM, I still need to go back to Chrome DevTools. But I find myself debugging much faster in VSCode, which I use everyday for coding.

## Example Code

[https://github.com/octref/vscode-electron-debug](https://github.com/octref/vscode-electron-debug)

[Open an issue](https://github.com/octref/vscode-electron-debug/issues/new) if you have any question.


