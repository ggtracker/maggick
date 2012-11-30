echo "Generating final icons.."

unit=$(dirname "$1")
filename=$(basename "$1")
extension="${filename##*.}"
filename="${filename%.*}"

# generate a 2 color "alpha map" of sorts
convert $1 -blur 0x30 -unsharp 0x20 -colorspace Gray +dither -colors 2 -threshold 70% _$unit.png

# this was a try to just get the edges
# convert test2.png -negate -morphology EdgeIn Diamond -negate test3.png
# convert test2.png -morphology EdgeIn Diamond -negate test3.png

# autotrace the 2-color map to svg
autotrace -output-format svg -output-file _tmp.svg -line-threshold 3 _$unit.png

# blur it back into an image
#convert _tmp.svg -blur 5x4.5 _shadow.png
convert _tmp.svg -blur 5x10.5 _shadow.png

# use it as a "drop shadow"
convert _shadow.png $1 -resize 76x76 -compose over -composite -gravity center -extent 76x76 -fill transparent +repage final/$unit.png

rm _tmp.svg
rm _shadow.png
rm _$unit.png
