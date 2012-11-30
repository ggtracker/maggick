#!/bin/bash
mkdir -p $2
ffmpeg -i $1 -r 10 -an -f image2 -pix_fmt rgba "$2/%05d.png"
cd $2
# removes transparent color and produces transparent png
../trans_png.sh
# converts nicely into smaller transparent gif
../trans_gif.sh
cd ..
# ffmpeg -i "$2/%05d.png" -an -f image2 -pix_fmt rgba $2.gif

# make an animated gif!
gifsicle --delay 1 --optimize --loop --colors 256 --crop-transparency -D 2 $2/tr*gif > final/$2.gif

# and create the "icons" from the first still
./generate_icon.sh "$2/tr_00001.png"
