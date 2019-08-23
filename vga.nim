
const
    VGA_W* = 80
    VGA_H* = 25

type vram = ptr array[0..VGA_W*VGA_H*2,distinct uint16]

const VGA* = cast[vram](0xB8000)

type VGAColor* = enum
    Black = 0,
    Blue = 1,
    Green = 2,
    Cyan = 3,
    Red = 4,
    Magenta = 5,
    Brown = 6,
    Grey = 7,
    DGrey = 8,
    LBlue = 9,
    LGreen = 10,
    LCyan = 11,
    LRed = 12,
    LMagenta = 13,
    Yellow = 14,
    White = 15
