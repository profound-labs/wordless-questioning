#!/bin/bash

org_options='#+OPTIONS: toc:nil author:nil d:nil ^:{}'

for i in ./manuscript/org/[0-9][0-9]*.org; do
    name=$(basename "$i" .org)
    dest=./manuscript/tex/"$name".tex

    cat "$i" |\
    # append export options
    sed 's/^#+TITLE.*$/&\n'"$org_options"'\n/' |\
    # strip task counter [0/2]
    perl -0777 -pe "s/(\n\\* +.*?) +\[[[0-9\/]+\]\n/\1\n/" |\
    pandoc -f org -t latex --top-level-division=chapter > "$dest"
done
