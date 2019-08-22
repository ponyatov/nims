echo "\niot/FORTH implementation in Nim language"
echo "(c) Dmitry Ponyatov <dponyatov@gmail.com>"

const                   # configuration
    Msz = 0x1000        # main memory, bytes
    Rsz = 0x100         # return stack size, cells
    Dsz = 0x10          # data size, cells

type
      byte    = uint8
      cell    = uint16          # \ 64K limited
const cellsz  = sizeof(cell)    # / for tiny MCUs

# var M[Msz]:bytes
var                     ## program/data memory
                        # bytecode area
    Ip:cell = 0         # instruction pointer
    Cp:cell = 0         # compiler pointer

var                     ## return stack
    Rp:cell = 0

var                     ## data stack
    Dp:byte = 0

echo "\nMsz:",Msz,"  Rsz:",Rsz,"  Dsz:",Dsz

type
    opcode = enum
        nop     = 0x00
        jmp     = 0x01,     qjmp    = 0x02
        call    = 0x03,     ret     = 0x04
        lit     = 0x05
        dup     = 0x10,     drop    = 0x11
        swap    = 0x12,     over    = 0x13
        press   = 0x14,     dropall = 0x1F
        key     = 0x20,     emit    = 0x21
        bye     = 0xFF

# echo {nop,bye}
