#!/bin/bash
#
# (Re-)Generates various sizes of the race icons from their base image
# Also creates inverted versions (base should be black)
#
# Specify size as first argument, final result will be in icons/<size>/

mkdir -p plain

for w in 16 24 32 48 64; do
	h=$w

	for k in *png; do

		filename=$(basename "$k")
		extension="${filename##*.}"
		filename="${filename%.*}"

		echo "$k -> plain/$filename\-$w.png ($w x $h)"

		convert $k -colorspace Gray -black-threshold 90% -contrast -resize $w\x$h -unsharp 0x1 plain/$filename\-$w.png
		convert plain/$filename\-$w.png -negate plain/$filename\-$w\-white.png
	#exit
	done
done
