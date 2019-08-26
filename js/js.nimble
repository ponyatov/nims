# Package

version       = "0.0.1"
author        = "Dmitry Ponyatov"
description   = "JavaScript demo"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["js.js"]

backend       = "js"

# Dependencies

requires "nim >= 0.20.2"
