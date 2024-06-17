# TiddlyWiki for Apple

This SwiftUI app uses [nodejs-mobile](https://github.com/nodejs-mobile/nodejs-mobile) to offer TiddlyWiki on Node.js with an embedded webview.

Read the [announcement post on talk.tiddlywiki.org](https://talk.tiddlywiki.org/t/announcing-a-tiddlywiki-app-for-apple-devices/9976).

If all goes well, this app will be moved to the main TiddlyWiki 5 repository into a new `/platforms` folder.

![IMG_0136](https://github.com/Jermolene/TiddlyWiki-for-Apple/assets/174761/189b348c-fa27-4e50-9c86-7c7154a03381)

# Progress

* [x] Basic integration with Node.js
* [x] Embedded webview
* [x] Refresh toolbar button
* [x] Embedded browser to handle external links
* [ ] Make user interface strings be translateable
* [ ] Integrate better-sqlite3, allowing MWS to be enabled
* [ ] Continuous integration
* [ ] Better way to embed the TW5 repository
* [ ] Choose available port instead of hardwiring 8080
* [ ] Capture and display terminal output
* [ ] Support terminal input and running npm
* [ ] Stop, start, restart server
* [ ] Automatically restart server after background switch
