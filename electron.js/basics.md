# Notes from https://electron.atom.io/docs

Electron uses Chromium for displaying web pages
Uses Node.js APIs in web pages allowing lower level operating system interactions

Main process: creates web pages by creating BrowserWindow
Each BrowserWindow instance runs the web page in its own {renderer process}.

The main process manages all web pages and their corresponding renderer processes. Each renderer process is isolated and only cares about the web page running in it.

Ways to communicate between the main process and renderer processes:



