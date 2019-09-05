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

import anygui

echo anygui.backend()

# import wNim

# import ../res/res

# let app = App()
# let frame = Frame(title= $exe & ' ' & $args)
# frame.icon = Icon("", 0)

# let menuBar = MenuBar(frame)

# type
#   MenuId = enum
#     idNew = 100, idLoad, idSave, idSaveAs, idExit,
# 	idAbout

# let menuFile = Menu(menuBar, "&File")
# menuFile.append(idNew, "&New")
# menuFile.append(idLoad, "&Load")
# menuFile.append(idSave, "&Save\tCtrl+S")
# menuFile.append(idSaveAs, "S&ave As...")
# menuFile.appendSeparator()
# menuFile.append(idExit, "E&xit\tCtrl+Q", "Exit the program.")

# let menuHelp = Menu(menuBar, "&Help")
# menuHelp.append(idAbout, "&About\tF1")
  
# let statusBar = StatusBar(frame)

# let notebook = NoteBook(frame)
# notebook.addPage("console")
# notebook.addPage("stack")
# notebook.addPage("vocabulary")

# frame.show()
# app.mainLoop()

