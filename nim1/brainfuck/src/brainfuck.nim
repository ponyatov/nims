import os

let code = if paramCount() > 0: readFile paramStr(1)
           else: ">+" # readAll stdin

echo code

var
    tape = newSeq[char]()
    codePos = 0
    tapePos = 0

proc step(skip = false) =
    case code[codePos]
    of '>':
        inc tapePos
        if tapePos >= tape.len: tape.add '\0'
    of '<': dec tapePos
    of '+': inc tape[tapePos]
    of '-': dec tape[tapePos]
    else: discard
    inc codePos

proc state =     
    echo "codePos: ", codePos, " tapePos: ", tapePos, " cmd: " , code[codePos]

proc run(skip = false): bool =
    state()
    while codePos < code.len:
        step() ; state()
    true

discard run()
