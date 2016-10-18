const electron = require("electron");

const app = electron.app;
const BrowserWindow = electron.BrowserWindow;

const ipcMain= electron.ipcMain

app.on("window-all-closed", function() {
    if (process.platform != "darwin") { app.quit(); }
});

app.on("ready", function() {
    let mainWindow = new BrowserWindow({
        width: 1600,
        height: 640,
    });
    mainWindow.loadURL(`file://${__dirname}/build/index.html`);
    mainWindow.webContents.openDevTools();

    //TODO:: make this toggle ON & OFF
    ipcMain.on("scrollbarDebug", () => {
        // mb.window.webContents.insertCSS('[data-player] {height: 120px!important;}');
        mainWindow.webContents.insertCSS('::-webkit-scrollbar-thumb {background: white!important;}');
        mainWindow.webContents.insertCSS('::-webkit-scrollbar-thumb:hover {background: yellow!important;}');
        mainWindow.webContents.insertCSS('::-webkit-scrollbar-thumb:active {background: green!important;}');
        mainWindow.webContents.insertCSS('::-webkit-scrollbar-track {background: blue!important;}');
        mainWindow.webContents.insertCSS('::-webkit-scrollbar-track:hover {background: purple!important;}');
        mainWindow.webContents.insertCSS('::-webkit-scrollbar-track:active {background: deeppink!important;}');
        mainWindow.webContents.insertCSS('::-webkit-scrollbar-corner {background: transparent!important;}');
        console.log('scrollbar debug colors ON')
    });
});

ipcMain.on("console.log", (event, arg) => {
    console.log(arg)
})

