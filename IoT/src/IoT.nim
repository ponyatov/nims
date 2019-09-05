# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import IoTpkg/submodule

import nigui

app.init()

import os

let window = newWindow($ os.getAppFilename())

window.iconPath = "IoT.png"

let inner = newLayoutContainer(Layout_Vertical) ; window.add(inner)

let btn = newLayoutContainer(Layout_Horizontal) ; inner.add(btn)

let about = newButton("About") ; btn.add(about)
about.onClick = proc(event: ClickEvent) = window.alert("platform","IoT")

let ide = newLayoutContainer(Layout_Horizontal) ; inner.add(ide)

let ostab = newLayoutContainer(Layout_Vertical) ; ide.add(ostab)

ostab.frame = newFrame("ostab Row 1: Auto-sized")

let files = newTextArea() ; ostab.add(files)
files.addLine "Files"
# files.width = 111

let shell = newTextArea() ; ostab.add(shell)
shell.addLine "shell>"

let cli = newLayoutContainer(Layout_Vertical) ; ide.add(cli)

let words = newTextArea() ; ide.add(words)
words.addLine "Words"

let stack = newTextArea() ; cli.add(stack) ; stack.addLine "<stack:>"
let pad = newTextArea() ; cli.add(pad) ; pad.addLine "# command"
let log = newTextArea() ; cli.add(log) ; log.addLine "log"

window.onResize = proc(event: ResizeEvent) =
  echo window.width
  ostab.width = max(111, window.width div 5 )
  words.width = max(111, window.width div 5 )
  stack.height = window.height div 2

window.show()
app.run()
