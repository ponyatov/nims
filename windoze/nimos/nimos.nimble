# Package

version       = "0.0.1"
author        = "Dmitry Ponyatov"
description   = "NimOS guest for Windows XP+"
license       = "MIT"
srcDir        = "src"
bin           = @["nimos"]

backend       = "cpp"

# Dependencies

requires "nim >= 0.20.2"
# requires "winim"
# requires "wNim"

requires "https://github.com/ponyatov/nims/tree/master/anygui#2fd41ff"
