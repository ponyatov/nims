# match/update computing method

const src = """12345
abcdefgh"""

echo src

iterator chars(src:string): string = discard
# for i in src: yield i

for i in src.chars: echo i
