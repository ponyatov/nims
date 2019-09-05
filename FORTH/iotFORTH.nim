##############################################################
# iotFORTH/nim
##############################################################
# https://forum.nim-lang.org/t/5164


type                                    ## IoT 16bit
    cell  =  int16                      # \ 64K limited
    ucell = uint16                      # / for tiny MCUs
    byte  = uint8

const                                   ## memory sizes
    Msz = 1'u16 shl 0xC                 # main memory, bytes
    Rsz = 1'u16 shl 0x8                 # return stack size, cells
    Dsz = 1'u8  shl 0x4                 # data stack size, cells

type                                    ## limited pointer types
    mp = range[0'u16..Msz-1]
    rp = ucell # range[0..Rsz-1]
    dp =  byte # range[0..Dsz-1]
                                        # wrapped operators
proc `+`(a:mp,b:int):mp =
    result = a + mp(b)
    assert result < high(mp)
    
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
    M : array[mp,byte]              # bytecode area
    Cp = mp(0)                      # instruction pointer
    Ip = mp(0)                      # compiler pointer
const init =                        # initial program
    [nop,bye]
var                                 # data stack
    D : array[Dsz,cell]
    Dp = dp(0)
var                                 # return stack
    R : array[Rsz,mp]
    Rp = rp(0)

log "\ninit:",init
                                    # store to M[]
proc store(a:mp,b:byte) =
    M[a] = b
proc store(a:mp,b:ucell) =
    M[a+0] = cast[byte](b shr 0)
    M[a+1] = cast[byte](b shr 8)
proc store(a:mp,b:mp) =
    store(a,ucell(b))
                                    # compile to end of used M[]
proc compile(b:byte):mp =
    let Csave = Cp
    store(Cp,b) ; inc Cp
    return Csave
proc compile(a:mp):mp =
    let Csave = Cp
    store(Cp,a) ; Cp += mp(sizeof(a))
    return Csave
proc compile(bc:op):mp = compile(byte(bc))
    
                                    ## compile bytecode header
discard     compile(byte(op.jmp))   # zero jmp
let entry = compile(mp(0))          # to program entry point
let lfa   = compile(mp(0))          # last defined word LFA

store(entry,Cp)                     # run init[] program from here
for i in 0..init.len-1:
    discard compile(init[i])

log "\nM:",M[0..uint16(Cp)-1] , "\nCp:",Cp , "\tIp:",Ip, '\n'

proc NOP() = discard
proc BYE() = log '\n' ; quit(0)
proc JMP() = Ip = M[Ip] ; log '\t',Ip.toHex

proc DROP() = dec Dp

proc VM() =
    while true:
        var bc = M[Ip] ; inc Ip
        log '\n',int(Ip).toHex(4),'\t',$op(bc)
        case (bc):
            of ord(nop): NOP()
            of ord(bye): BYE()
            of ord(jmp): JMP()
            else: quit(-1)
VM()
