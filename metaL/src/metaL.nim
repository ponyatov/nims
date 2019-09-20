# metaL/nim : port of FORTH-like homoiconic script language for embedded/IoT
# (c) Dmitry Ponyatov <<dponyatov@gmail.com>> 2019 MIT
# github: https://github.com/ponyatov/nims/metaL/

import os

type Frame = ref object # ref object of RootObj
  tag: string
  val: string
  # slot: Table[string; Frame]
  nest: seq[Frame]

proc `*`(this:string, that:int): string =
  var s = ""
  for i in 1..that: s = ( s & this )
  return s
proc pad(_:Frame, depth:int): string = "\n" & "\t" * depth
proc head(this: Frame, prefix:string): string = "<" & this.tag & ":" & this.val & ">"
proc dump(this: Frame, depth:int =0, prefix:string =""): string =
  let tree = this.pad(depth) & this.head(prefix)
  return tree
proc `$`(this: Frame): string = this.dump()
proc `//`(this: Frame, that:Frame): Frame =
  this.nest.add(that)
  return this

proc REPL =
  while true:
    stdout.write("\nok> ")
    let cmd = stdin.readLine
    echo "cmd:" & cmd

when isMainModule:
  echo paramStr(0)
  echo Frame(tag:"Hello", val:"World") // Frame(val:"pushed")
  # REPL()
