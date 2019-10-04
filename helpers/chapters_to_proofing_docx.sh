#!/bin/bash

org_title=./manuscript/org/title.org

html_toc=./manuscript/html/toc.html
combined_org_dest=./manuscript/combined-en.org
combined_html_dest=./manuscript/combined-en.html
combined_docx_dest=./manuscript/mwoh.docx

reference_doc=./helpers/proofing-reference.docx

table_opening="#+begin_export html\n<table><col width='68%'><col width='32%'><tbody>\n#+end_export"

table_closing="#+begin_export html\n<\\/tbody><\\/table>\n#+end_export"

before_text="#+begin_export html\n<tr><td>\n#+end_export"

before_topics="#+begin_export html\n<\\/td><td>\n#+end_export"

after_topics="#+begin_export html\n<\\/td><\\/tr>\n#+end_export"

# Start with the title and toc.
cat "$org_title" > "$combined_org_dest"

# Concatenate org chapters to one file.

for i in ./manuscript/org/[0-9][0-9]*-en.org; do
    cat "$i" |\
    # strip the org-title
    sed '/#+TITLE/d' |\
    # remove the first :noexport: header
    perl -0777 -pe "s/\n\\* +.*? :noexport:.*?(\n\\* +)/\1/s" |\
    # strip task counter [0/2]
    perl -0777 -pe "s/(\n\\* +.*?) +\[[[0-9\/]+\]\n/\1\n/" |\
    # table opening
    perl -0777 -pe "s/(\n\\* +.*\n)/\1\n$table_opening\n/" |\
    # table closing
    perl -0777 -pe "s/$/\n$table_closing\n/" |\
    # swap the drawer and the text, insert <tr> <td> tags
    perl -0777 -pe "s/(\n:NOTES:.*?)(\n#\+begin_text.*?#\+end_text\n)/\n$before_text\n\2\n$before_topics\n\1\n$after_topics\n/gs" |\
    cat -s >> "$combined_org_dest"
done

# Convert to html, then to docx.

pandoc -f org -t html --standalone -o "$combined_html_dest" "$combined_org_dest"

pandoc -f html -t docx --reference-doc="$reference_doc" -o "$combined_docx_dest" "$combined_html_dest"

# Clean up.

rm "$combined_org_dest"
rm "$combined_html_dest"

