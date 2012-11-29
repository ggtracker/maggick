#!/bin/bash
#
# (Re-)Generates various sizes of the league icons from their base
# Also creates bw versions (base should be colored)
# And now also generates all sizes from our 112x112 default

mkdir -p output

for w in 16 32 48 64; do
	h=$w

	for k in plain-color/*png; do

		filename=$(basename "$k")
		extension="${filename##*.}"
		filename="${filename%.*}"

		echo "$k -> plain/$filename\-$w.png ($w x $h)"

		convert $k -resize $w\x$h output/$filename\-color\-$w.png
		convert $k -colorspace Gray -black-threshold 90% -contrast -resize $w\x$h output/$filename\-$w.png
		convert output/$filename\-$w.png -negate output/$filename\-white\-$w.png
	#exit
	done

	# Game league icons
	for k in mpq/*png; do

		filename=$(basename "$k")
		extension="${filename##*.}"
		filename="${filename%.*}"

		echo "$k -> processed/$filename\-$w.png ($w x $h)"

		convert $k -resize $w\x$h output/$filename\-mpq\-$w\.png
                convert $k \( \
                        +clone -background '#2cd7ff' -shadow 70x6+0+0 \
                        -channel A -level 0,60% +channel \
                \) \
                -background none -compose DstOver -flatten \
		-channel A -virtual-pixel transparent -morphology Distance Euclidean:8,8! \
                -resize $w\x$h output/$filename\-mpq-glow-$w.png
	#exit
	done

done
