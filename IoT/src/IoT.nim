# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import IoTpkg/submodule

import nigui

app.init()

import os

let window = newWindow($ os.getAppFilename())

window.iconPath = "IoT.png"

let carr = newLayoutContainer(Layout_Vertical) ; window.add(carr)

let btn = newLayoutContainer(Layout_Horizontal) ; carr.add(btn)

let about = newButton("About") ; btn.add(about)
about.onClick = proc(event: ClickEvent) = window.alert("IoT platform")

let ide = newLayoutContainer(Layout_Horizontal) ; carr.add(ide)

let ostab = newLayoutContainer(Layout_Vertical) ; ide.add(ostab)

let files = newTextArea() ; ostab.add(files)
files.addLine "Files"

let shell = newTextArea() ; ostab.add(shell)
shell.addLine "shell>"

let cli = newLayoutContainer(Layout_Vertical) ; ide.add(cli)

let words = newTextArea() ; ide.add(words)
words.addLine "Words"

let stack = newTextArea() ; cli.add(stack) ; stack.addLine "<stack:>"
let pad = newTextArea() ; cli.add(pad) ; pad.addLine "# command"
let log = newTextArea() ; cli.add(log) ; log.addLine "log"

window.show()
app.run()
