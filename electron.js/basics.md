# Notes from https://electron.atom.io/docs

Electron uses Chromium for displaying web pages
Uses Node.js APIs in web pages allowing lower level operating system interactions

Main process: creates web pages by creating BrowserWindow
Each BrowserWindow instance runs the web page in its own {renderer process}.

The main process manages all web pages and their corresponding renderer processes. Each renderer process is isolated and only cares about the web page running in it.

## Sharing Data Between Pages
(Ways to communicate between the main process and renderer processes)
- StorageAPI
- localStorage
- sessionStorage
- IndexedDB
- IPC System, specific to electron

```js
// In the main process.
global.sharedObject = {
  someProperty: 'default value'
}
// in page 1
require('electron').remote.getGlobal('sharedObject').someProperty = 'new value'
// in page 2
console.log(require('electron').remote.getGlobal('sharedObject').someProperty)
```

