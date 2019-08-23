import author
echo "\niot/FORTH implementation in Nim language"
echo AUTHOR

const                   # configuration
    Msz = 0x1000        # main memory, bytes
    Rsz = 0x100         # return stack size, cells
    Dsz = 0x10          # data size, cells

echo "\nMsz:",Msz,"  Rsz:",Rsz,"  Dsz:",Dsz

type
      byte    = uint8
      cell    = int16           # \ 64K limited
      ucell   = uint16
const cellsz  = sizeof(cell)    # / for tiny MCUs

type
    opcode = enum
        nop     = (0x00,"nop")

        jmp     = (0x01,"jmp"),     qjmp    = (0x02,"?jmp")
        call    = (0x03,"call"),    ret     = (0x04,"ret")
        lit     = (0x05,"lit")

        dup     = (0x10,"dup"),     drop    = (0x11,"drop")
        swap    = (0x12,"swap"),    over    = (0x13,"over")
        press   = (0x14,"press"),   dropall = (0x1F,".")

        key     = (0x20,"key"),     emit    = (0x21,"emit")

        add     = (0x30,"+"),       sub     = (0x31,"-"),
        mul     = (0x32,"*"),       divv    = (0x33,"/"),
        pow     = (0x34,"^"),       modd    = (0x35,"%"),

        bye     = (0xFF,"bye")

# echo {nop,bye}

# var M[Msz]:bytes
var                             ## program/data memory
    M : array[0..Msz,byte]      # bytecode area
    Ip:cell = 0                 # instruction pointer
    Cp:cell = 0                 # compiler pointer

const prog = [nop,bye]          # initial program

proc compile(cmd: opcode) =
    M[Cp] = ord(cmd) ; Cp += 1

assert(sizeof(prog) < sizeof(M))
for i in prog: compile(i)
echo " Cp:",Cp

var                             ## return stack
    R : array[0..Rsz,ucell]      
    Rp:cell = 0

var                             ## data stack
    D : array[0..Dsz,cell]
    Dp:byte = 0

for i in 0..Cp: echo i,'\t',M[i],'\t',ord(M[i])

import system

proc NOP = stdout.write "nop"

proc BYE = stdout.write "bye\n" ; system.quit 0

proc BCX =                      ## ByteCode eXecutor
    while true:
        assert(Ip < Msz)
        var op = M[Ip] ; Ip += 1    # fetch command
        stdout.write "\n",Ip-1,":\t",op,'\t'
        case op
        of ord(nop): NOP()
        of ord(bye): BYE()
        else: echo "unknown command" ; quit(-1)
BCX()
