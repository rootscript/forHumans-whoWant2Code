'use strict';
//node_modules START...
const {ipcRenderer} = require('electron');

const $ = require('jquery');
const Rx = require('rxjs/Rx');

//node_modules ...END



//function_statements START...

// function cLog(message, value) {
//     ipcRenderer.send('console.log', 'cLog :: '+message +' - ' +value)
// }
// cLog('what is the window height?', chatWinHeight)

//NOTE:: function_statements are hoisted into memory, and can be called before or after the statement
//NOTE:: f_expressions: var name=function(){}, these set the var to undefined, before excuting the code
//NOTE:: f_statements are functions, f_expressions are hoisted as a variable first, before the function is run
//NOTE:: the value of a f_statement is created on the fly into memory, the value of an f_expression is assigned to a variable

//function_statements ...END




//rx observables from Events START...
const btn = $('#rxbtn');
const outputMouse = $('#rxoutputMouse')

//rx button START...
const btnStream$ = Rx.Observable.fromEvent(btn, 'click');


//short ES6 version
btnStream$.subscribe(
    e => {
        ipcRenderer.send('console.log', 'clg.01 - Clicked - event values = ' +e.target.innerHTML)
    },
    err => ipcRenderer.send('console.log', 'clg.01e - Error'+err),
    () => ipcRenderer.send('console.log', 'clg.01c - Completed')
)

//rx button ...END


//rx mouse coordinates START...

const moveStream$ = Rx.Observable.fromEvent(document, 'mousemove');
// moveStream$.debounceTime(100000)

moveStream$.throttleTime(50)
    .subscribe(
    e => {
        outputMouse.html('<h4>X: ' +e.clientX +'Y: ' +e.clientY +'</h4>')
    },
    err => ipcRenderer.send('console.log', 'clg.03e - Error'+err),
    () => ipcRenderer.send('console.log', 'clg.03c - Completed')
)
//rx mouse coordinates ...END



//rx observables from Events ...END



//right click menu START...
//LINK:: https://github.com/electron/electron/blob/master/docs/api/menu.md
const {remote} = require('electron')
const {Menu, MenuItem} = remote
const menu = new Menu()
let rightClickPosition = null



menu.append(new MenuItem({label: 'copy Selected Text', click: () => { ipcRenderer.send('copytext'); }}))
menu.append(new MenuItem({label: 'paste Text', click: () => { ipcRenderer.send('pastetext'); }}))
menu.append(new MenuItem({label: 'browser Go Back', click: () => { ipcRenderer.send('goback'); }}))


// var browserSelectedText = require('browser-selected-text');
// menu.append(new MenuItem({label: 'ghThumb', click: () => { ipcRenderer.send('ipcR2ipcM-02', ('LOG.02 - '+doSomethingFunction(browserSelectedText())  )); }}))

// menu.append(new MenuItem({label: 'MenuItem1-copyName', click: () => { window.webContents.copy() }}))
menu.append(new MenuItem({type: 'separator'}))
menu.append(new MenuItem({label: 'liMod', type: 'checkbox', checked: true}))
menu.append(new MenuItem({label: 'mpvMod', type: 'checkbox', checked: true}))
menu.append(new MenuItem({type: 'separator'}))

const webview = document.getElementById('foo')
menu.append(new MenuItem({label: 'webview Go Back', click: () => { webview.goBack(); }}))
menu.append(new MenuItem({label: 'webview set zoom', click: () => { webview.setZoomLevel(-5); }}))
menu.append(new MenuItem({label: 'webview reset zoom', click: () => { webview.setZoomLevel(0); }}))
menu.append(new MenuItem({label: 'webview openDevTools', click: () => { webview.openDevTools(); }}))
menu.append(new MenuItem({label: 'webview reload', click: () => { webview.reload(); }}))
menu.append(new MenuItem({label: 'webview insertCSS', click: () => { webview.insertCSS('#player_content {width: 435px!important;}') }}))
menu.append(new MenuItem({type: 'separator'}))
menu.append(new MenuItem({label: 'webview getURL', click: () => { cLog('webview getURL = ', webview.getURL()) }}))
menu.append(new MenuItem({label: 'webview mpv getURL', click: () => { exec("/Users/rootscript/scripts/./mpvv.sh "+webview.getURL()); }}))



menu.append(new MenuItem({type: 'separator'}))
menu.append(new MenuItem({
    label: 'Inspect Element',
    click: () => {
        remote.getCurrentWindow().inspectElement(rightClickPosition.x, rightClickPosition.y)
    }
}))

window.addEventListener('contextmenu', (e) => {
    e.preventDefault()
    rightClickPosition = {x: e.x, y: e.y}
    menu.popup(remote.getCurrentWindow())
}, false)
//right click menu ...END



//right click menu START...
//LINK:: https://github.com/electron/electron/blob/master/docs/api/menu.md

//right click menu ...END



// ipcRenderer.send('modson', cbArrayIntersection.length)

//INFO:: Useful docs
//LINK:: https://github.com/Reactive-Extensions/rxjs-jquery/blob/master/readme.md cool explanation
//LINK:: https://github.com/Reactive-Extensions/RxJS/blob/master/doc/gettingstarted/backpressure.md
//RxJS for DOM Bindings AutoComplete Example - combining input events such as keyup with Ajax requests
//LINK:: http://jsfiddle.net/mattpodwysocki/AL8Mj/



