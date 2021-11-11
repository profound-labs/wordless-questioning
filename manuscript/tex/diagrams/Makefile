LATEX=latexmk
LATEX_OPTS=-pdflua

all: dia

dia:
	lualatex -interaction=nonstopmode -halt-on-error dia.tex

all-diagrams: feeling-identification.pdf mindfulness-of-breathing.pdf

%.pdf: %.tex
	$(LATEX) $(LATEX_OPTS) $<

preview $(FILE):
	latexmk -pdflua -pvc -e '$$latex=q/latex %O -interaction=nonstopmode -halt-on-error %S/' $(FILE)

clean:
	rm -f *.aux *.log *.fdb_latexmk *.fls
