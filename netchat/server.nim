# file:///home/dpon/doc/Nim/Nim%20in%20Action.pdf p.60

import os

echo paramStr(0)

var adddr:string
if paramCount() == 0:
    adddr = "localhost"
else:
    adddr = paramStr(1)

echo adddr

import threadpool

proc count:int = 
    var n =0
    while n<999: inc n
    return n

let th = spawn count()
var c = 0
while not th.isReady:
    inc c ; echo c

# stdout.write("\nmsg> ")
# let msg = spawn stdin.readLine()
# # echo "\nspawned " & $msg
# echo "message:" & ^msg

