#!/bin/bash

ORG_OPTIONS='#+OPTIONS: toc:nil author:nil d:nil ^:{}'

for i in ./manuscript/org/*.org
do
    name=$(basename "$i" .org)
    dest=./manuscript/docx/"$name".docx
    cat "$i" | \
        sed 's/^\(#+TITLE:.*\)$/\1\n'"$ORG_OPTIONS"'\n/' | \
        pandoc -f org -t docx -o "$dest"
done
