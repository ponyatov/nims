echo "hello"

const
    VGA_W = 80
    VGA_H = 25

type vram = ptr array[0..VGA_W*VGA_H*2,distinct uint16]

const VGA = cast[vram](0xB8000)
