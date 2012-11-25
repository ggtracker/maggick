#!/bin/bash
#
# (Re-)Generates various sizes of general UI icons

mkdir -p icons

for w in 16 24 32; do
	h=$w

	for k in originals/*png; do

		filename=$(basename "$k")
		extension="${filename##*.}"
		filename="${filename%.*}"

		echo "$k -> plain/$filename\-$w.png ($w x $h)"

		convert $k -resize $w\x$h icons/$filename\-$w.png
		convert $k -negate -resize $w\x$h icons/$filename\-white\-$w.png
	#exit
	done
done
