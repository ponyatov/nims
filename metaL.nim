import author
echo "metaL homoiconic runtime / Nim implementation /"
echo AUTHOR

import tables

type Frame = object
    typ: string
    val: string
    slot: Table[string,ptr Frame]
    nest: seq[ptr Frame]

echo Frame()
