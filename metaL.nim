import author
echo "metaL homoiconic runtime / Nim implementation /"
echo AUTHOR

import tables

type
    Frame = ref object of RootObj
        typ: string
        val: string
        slot: Table[string,Frame]
        nest: seq[Frame]

method head(this:Frame): string {.base.} = "<" & this.typ & ":" & this.val & ">"
    
# method head(this:Frame,prefix=""):string = "<" & this.typ &":"& this.val &">"

let nst = Frame(val:"nested")
echo nst.head()

let hello = Frame(typ:"hello",val:"world")#,nest:@[])
echo hello[]
