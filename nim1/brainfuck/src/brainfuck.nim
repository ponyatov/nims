import os

let code = if paramCount() > 0: readFile paramStr(1)
           else: "<><><<><>" # readAll stdin

echo code

var
    tape = newSeq[char]()
    codePos = 0
    tapePos = 0
    