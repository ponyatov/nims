# https://howistart.org/posts/nim/1/

var x = 0
for i in 1 .. 100_000_000:
  inc x # increase x, this is a comment btw

echo "Hello World ", x
