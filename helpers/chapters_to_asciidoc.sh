#!/bin/bash

for i in ./manuscript/tex/[0-9][0-9]*.tex; do
    ./helpers/tex_to_asciidoc.sh "$i"
done

