##############################################################
# iotFORTH/nim
##############################################################
# https://forum.nim-lang.org/t/5164


type                                ## IoT 16bit
    cell  =  int16                  # \ 64K limited
    ucell = uint16                  # / for tiny MCUs
    byte  = uint8

const                               ## memory sizes
    Msz = 1 shl 0xC                 # main memory, bytes
    Rsz = 1 shl 0x8                 # return stack size, cells
    Dsz = 1 shl 0x4                 # data stack size, cells

type                                ## limited pointer types
    Mptr = range[0..Msz-1]
    Rptr = range[0..Rsz-1]
    Dptr = range[0..Dsz-1]
    
import os,strutils

proc log(args:varargs[string,`$`]) = stdout.write(args)

log getAppFilename()

log "\nMsz:",Msz,"  Rsz:",Rsz,"  Dsz:",Dsz,  "\n"

type                                # bytecode commands
    op = enum # opcode

        nop     = (0x00'u8,"nop")

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

var                                 ## program/data memory
    M : array[Msz,byte  ]           # bytecode area
    Cp = ucell(0)                   # instruction pointer
    Ip = ucell(0)                   # compiler pointer
const init =                        # initial program
    [nop,bye]
var                                 # data stack
    D : array[Dsz,int16 ]
    Dp = byte(0)
var                                 # return stack
    R : array[Rsz,cell  ]
    Rp = ucell(0)

log "\ninit:",init

proc store(a:ucell,b:byte) =
    M[a] = b
proc store(a:ucell,b:ucell) =
    M[a+0] = byte(b shr 0)
    M[a+1] = byte(b shr 8)

proc compile(b:byte):ucell =
    let Csave = Cp
    store(Cp,b) ; Cp += ucell(sizeof(b))
    return Csave
proc compile(c:ucell):ucell =
    let Csave = Cp
    store(Cp,c) ; Cp += ucell(sizeof(c))
    return Csave
proc compile(bc:op):ucell = compile(byte(bc))
    
                                    ## compile bytecode header
discard     compile(byte(op.jmp))   # zero jmp
let entry = compile(ucell(0))       # to program entry point
let lfa   = compile(ucell(0))       # last defined word LFA

store(entry,Cp)                     # run init[] program from here
for i in 0..init.len-1:
    discard compile(init[i])

log "\nM:",M[0..Cp-1] , "\nCp:",Cp , "\tIp:",Ip, '\n'

proc DROP() = assert(Dp > byte(0)) ; Dp -= byte(1)

proc VM() =
    while true:
        var bc = M[Ip] ; inc Ip
        log '\n',int(Ip).toHex(4),'\t',$op(bc)
        break
VM()
