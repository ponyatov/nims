# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

when isMainModule:
  echo("Hello, World!")

# proc log(any: varargs[string,`$`]) = stdout.write any

import os

let exe  = getAppFileName()    ; echo "exe  ",exe
let args = commandLineParams() ; echo "args ",args

echo "Hello","world",1,3.4

