#!/bin/bash

for i in ./manuscript/tex/diagrams/*.pdf; do
    name=$(basename "$i" '.pdf')
    out_file=./assets/photos/92dpi-ebook-sRGB/diagrams/$name.jpg

    echo "$name"

    convert -density 600 "$i" -flatten -compress jpeg -quality 90 -filter Lanczos -resize x800 -bordercolor white -border 5x5 "$out_file"

done
