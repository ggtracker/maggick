#!/bin/bash
#
# Generates slightly shadowed transparent png unit icons from btn-unit* DDS
#
# Specify size as first argument, final result will be in icons/<size>/

w=$1
h=$1

mkdir -p icons/$w

for k in dds/*dds; do

	filename=$(basename "$k")
	extension="${filename##*.}"
	filename="${filename%.*}"
	m=`expr match "$filename" '\(btn-[a-zA-Z]*-[a-zA-Z]*-\)'`
	unit="${filename//$m/}"

	echo "$k -> icons/$w/$unit.png ($w x $h)"

	convert $k -resize $w\x$h _tmp.png
	convert _tmp.png -fx "v.p{0,u*v.h}" -channel RGBA -gaussian-blur 0x1 -alpha on -channel RGB -evaluate set 50% +channel _tmpb.png
	convert \
		\( _tmpb.png \) \
		-compose over \
		\( _tmp.png -unsharp 0x1 \) \
		-compose over -composite -gravity center icons/$w/$unit.png

#exit
done

rm -f _tmp.png
rm -f _tmpb.png

# Handle some special case renaming..
mv icons/$w/warpray.png icons/$w/voidray.png
mv icons/$w/infestedmarine.png icons/$w/infestedterran.png

