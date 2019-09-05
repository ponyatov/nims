# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

# import webpkg/submodule

# when isMainModule:
#   echo(getWelcomeMessage())

import asynchttpserver, asyncdispatch, rosencrantz

let handler = get[
  path("/")[
    logResponse("ans: $1 $2 $5\n$6\n$7")[
    logRequest("\nreq: $1 $2\n$3")[
      ok("hello")
    ]]
  ]
]

let server = newAsyncHttpServer()

waitFor server.serve(Port(8080), handler)
