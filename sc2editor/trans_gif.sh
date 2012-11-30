#!/bin/bash

rm *diff*

for k in tr_*.png; do
k="${k%.*}"
echo "k: $k"
convert $k.png -resize 76x76 -gravity center -extent 76x76 -fill transparent -unsharp 0x1 +repage $k.gif
#convert $k.png -resize 150x -unsharp 0x1 $k.gif
done
