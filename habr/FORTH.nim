# FORTH/nim

type                                # IoT 16bit
    cell  =  int16
    ucell = uint16

const                               # memory sizes
    Msz = 0x1000
    Rsz = 0x100
    Dsz = 0x10

type                                # bytecode commands
    op = enum # opcode
        NOP  = 0x00'u8
        JMP  = 0x01
        qJMP = 0x02
        CALL = 0x03
        RET  = 0x04
        LIT  = 0x05
        BYE  = 0xFF

var                                 # memory
    M : array[Msz,byte  ]
    Cp = cell(0)
    Ip = cell(0)
const init =                        # initial program
    @[byte(op.NOP),byte(op.BYE)]
var
    D : array[Dsz,int16 ]
    Dp = cell(0)
var
    R : array[Rsz,cell  ]
    Rp = cell(0)

echo "init:",init

proc store(a:cell,b:byte) =
    M[a] = b
proc store(a:cell,b:cell) =
    M[a+0] = byte(b shr 0)
    M[a+1] = byte(b shr 8)

proc compile(b:byte):cell = store(Cp,b) ; Cp += cell(sizeof(b)) ; return Cp
proc compile(c:cell):cell = store(Cp,c) ; Cp += cell(sizeof(c)) ; return Cp

discard compile(byte(op.JMP))   # zero jmp
let entry = compile(cell(0))    # to program entry point
let lfa   = compile(cell(0))    # last defined word LFA

store(entry,Cp)                 # compile init[] program here
for i in 0..init.len-1: discard compile(init[i])

echo "M:",M[0..Cp] ; echo "Cp:",Cp ; echo "Ip:",Ip

proc DROP() = assert(Dp > cell(0)) ; Dp -= cell(1)
