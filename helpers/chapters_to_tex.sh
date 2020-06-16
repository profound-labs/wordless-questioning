#!/bin/bash

org_options='#+OPTIONS: toc:nil author:nil d:nil ^:{}'

for i in ./manuscript/org/[0][0-2]*.org; do
    name=$(basename "$i" .org)
    dest=./manuscript/tex/"$name".tex

    cat "$i" |\
    grep -v '^[:#] -*-' |\
    # append export options
    sed 's/^#+TITLE.*$/&\n'"$org_options"'\n/' |\
    # strip task counter [0/2]
    perl -0777 -pe "s/(\n\\* +.*?) +\[[[0-9\/]+\]\n/\1\n/" |\
    pandoc -f org+smart -t latex --top-level-division=chapter > "$dest"
done
