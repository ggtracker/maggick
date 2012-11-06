#!/bin/bash
#
# (Re-)Generates various sizes of the league icons from their base
# Also creates bw versions (base should be colored)

mkdir -p plain

for w in 16 32 48 64; do
	h=$w

	for k in plain-color/*png; do

		filename=$(basename "$k")
		extension="${filename##*.}"
		filename="${filename%.*}"

		echo "$k -> plain/$filename\-$w.png ($w x $h)"

		convert $k -resize $w\x$h plain/$filename\-$w\-color.png

		convert $k -colorspace Gray -black-threshold 90% -contrast -resize $w\x$h plain/$filename\-$w.png

		convert plain/$filename\-$w.png -negate plain/$filename\-$w\-white.png
	#exit
	done
done
