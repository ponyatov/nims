# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

when isMainModule:
  echo("Hello, World!")

# proc log(any: varargs[string,`$`]) = stdout.write any

import os

let exe  = getAppFileName()    ; echo "exe  ",exe
let args = @[exe] & commandLineParams() ; echo "args ",args

echo "Hello","world",1,3.4

# https://github.com/khchen/winim
# import winim/lean

import wNim

import ../res/res

let app = App()
let frame = Frame(title= $exe & ' ' & $args)
frame.icon = Icon("", 0)

let statusBar = StatusBar(frame)

let notebook = NoteBook(frame)
notebook.addPage("console")
notebook.addPage("stack")
notebook.addPage("vocabulary")

frame.show()
app.mainLoop()

