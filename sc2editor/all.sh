#!/bin/bash

for k in videos/*y4m; do
filename=$(basename "$k")
extension="${filename##*.}"
filename="${filename%.*}"

./to_seq.sh videos/$filename.y4m $filename
done
