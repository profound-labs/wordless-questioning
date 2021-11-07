FILE_EN=main-en
FILE_HU=main-hu

FILE=$(FILE_HU)

LATEX=lualatex
BIBTEX=bibtex

LATEX_OPTS=-interaction=nonstopmode -halt-on-error

all: document

four-times:
	./helpers/four-times.sh

document:
	$(LATEX) $(LATEX_OPTS) $(FILE).tex

copy-convert:
	bash -c 'cp ~/wiki/books/wordless-questioning/chapters/[0-9][0-9]-*-{en,hu}.org ~/prods/books/alpha/wordless-questioning-project/wordless-questioning_main/manuscript/org/'
	./helpers/chapters_to_tex.sh

en-update:
	bash -c 'cp ~/wiki/books/wordless-questioning/chapters/[0-9][0-9]-*-en.org ~/prods/books/alpha/wordless-questioning-project/wordless-questioning_main/manuscript/org/'
	./helpers/chapters_to_tex.sh
	$(LATEX) $(LATEX_OPTS) $(FILE_EN).tex

hu-update:
	bash -c 'cp ~/wiki/books/wordless-questioning/chapters/[0-9][0-9]-*-hu.org ~/prods/books/alpha/wordless-questioning-project/wordless-questioning_main/manuscript/org/'
	./helpers/chapters_to_tex.sh
	$(LATEX) $(LATEX_OPTS) $(FILE_HU).tex

en:
	$(LATEX) $(LATEX_OPTS) $(FILE_EN).tex

hu:
	$(LATEX) $(LATEX_OPTS) $(FILE_HU).tex

html:
	asciidoctor -D output stillness-flowing.adoc

epub:
	./helpers/generate_epub.sh $(FILE)

epub-validate:
	EPUBCHECK=~/bin/epubcheck asciidoctor-epub3 -D output -a ebook-validate main.adoc

mobi:
	./helpers/generate_mobi.sh $(FILE)

preview:
	latexmk -pvc $(FILE).tex

chapters-to-asciidoc:
	./helpers/chapters_to_asciidoc.sh

chapters-to-tex:
	./helpers/chapters_to_tex.sh

chapters-to-docx:
	./helpers/chapters_to_docx.sh

chapters-to-proofing-docx:
	./helpers/chapters_to_proofing_docx.sh

stylus-watch:
	stylus -w ./vendor/asciidoctor-epub3/assets/styles/*.styl -o ./vendor/asciidoctor-epub3/data/styles/

clean:
	+rm -fv $(FILE).{dvi,ps,pdf,aux,log,bbl,blg}

