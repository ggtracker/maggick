#!/bin/bash
#
# (Re-)Generates various sizes of the race icons from their base image
# Also creates inverted versions (base should be black)
#
# Specify size as first argument, final result will be in icons/<size>/

mkdir -p output

for w in 16 24 32 48 64; do
	h=$w

	for k in plain/*png; do

		filename=$(basename "$k")
		extension="${filename##*.}"
		filename="${filename%.*}"

		echo "$k -> plain/$filename\-$w.png ($w x $h)"

		convert $k -colorspace Gray -black-threshold 90% -contrast -resize $w\x$h -unsharp 0x1 output/$filename\-plain\-$w.png
		convert output/$filename\-plain\-$w.png -negate output/$filename\-plain\-white\-$w.png
	#exit
	done

	for k in color/*png; do

		filename=$(basename "$k")
		extension="${filename##*.}"
		filename="${filename%.*}"

		echo "$k -> color/$filename\-$w.png ($w x $h)"

		convert $k -resize $w\x$h -unsharp 0x1 output/$filename\-color\-$w.png
		convert $k \( \
			+clone -background '#2cd7ff' -shadow 80x10+0+0 \
			-channel A -level 0,40% +channel \
		\) \
		-background none -compose DstOver -flatten \
		-resize $w\x$h output/$filename\-color-glow-$w.png

		# this is an "inner glow", but it doesn't really look good on small sizes:
		# -channel A -virtual-pixel transparent -morphology Distance Euclidean:8,8! \
	#exit
	done
done
