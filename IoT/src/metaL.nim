
type Class = enum
    frame,
    prim, sym, str, num, int, hex, bin

type Frame = ref object of RootObj
    typ: Class
    val: string
    nest: seq[Frame]

import strformat

# proc id(f:Frame): uint = cast[uint](f.unsafeAddr)
proc `$`(f:Frame):string = fmt"<{f.typ}:{f.val}> @{cast[int](f.unsafeAddr)}"

if isMainModule:
    echo Frame(val:"Hello")
