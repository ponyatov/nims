# Package

version       = "0.0.1"
author        = "Dmitry Ponyatov"
description   = "metaL/nim : port of FORTH-like homoiconic script language for embedded/IoT"
license       = "MIT"
srcDir        = "src"
bin           = @["metaL"]

backend       = "cpp"

# Dependencies

requires "nim >= 0.20.2"
