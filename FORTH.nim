# FORTH implementation in Nim language
# (c) Dmitry Ponyatov <dponyatov@gmail.com>

const                   # configuration
    Msz = 0x1000        # main memory, bytes
    Rsz = 0x100         # return stack size, cells
    Dsz = 0x10          # data size, cells

# var M[Msz]:bytes
var                     ## program/data memory
                        # bytecode area
    Ip = 0              # instruction pointer
    Cp = 0              # compiler pointer

# array[Msz, bytes]

var
    Rp = 0

var 
    Dp = 0

echo "\nMsz:",Msz,"\tIp:",Ip
