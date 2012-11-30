#!/bin/bash

rm *diff*

for k in *.png; do
#k="${k%.*}"
echo "k: $k"
#convert $k -fuzz 10% -transparent "#28667D" -gravity Center -crop 90%x90%+0+0 tr_$k
convert $k -fuzz 10% -transparent "#4CAFD2" -gravity Center -crop 90%x90%+0+0 -trim +repage tr_$k
done
