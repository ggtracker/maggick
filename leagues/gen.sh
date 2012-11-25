#!/bin/bash
#
# (Re-)Generates various sizes of the league icons from their base
# Also creates bw versions (base should be colored)
# And now also generates all sizes from our 112x112 default

mkdir -p processed
mkdir -p plain-processed

for w in 16 32 48 64; do
	h=$w

	for k in plain-color/*png; do

		filename=$(basename "$k")
		extension="${filename##*.}"
		filename="${filename%.*}"

		echo "$k -> plain/$filename\-$w.png ($w x $h)"

		convert $k -resize $w\x$h plain-processed/$filename\-$w\-color.png

		convert $k -colorspace Gray -black-threshold 90% -contrast -resize $w\x$h plain/$filename\-$w.png

		convert plain/$filename\-$w.png -negate plain/$filename\-$w\-white.png
	#exit
	done

	# Game league icons
	for k in mpq/*png; do

		filename=$(basename "$k")
		extension="${filename##*.}"
		filename="${filename%.*}"

		echo "$k -> processed/$filename\-$w.png ($w x $h)"

		convert $k -resize $w\x$h processed/$filename\-$w\.png
	#exit
	done

done
