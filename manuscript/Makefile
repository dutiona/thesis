TEX = latexmk --pdf -pdflatex="pdflatex --shell-escape"
SRC = $(filter-out flyleaf.tex trash.tex main.old.tex, $(wildcard *.tex))
DEP = flyleaf.tex bibliography.bib $(wildcard chapters/*.tex)
PDF = $(SRC:.tex=.pdf)

all : $(PDF) compressed

%.pdf : %.tex ${DEP}
	$(TEX) $< -jobname="$(basename $<)"

%.compressed.pdf : %.tex ${DEP}
	\gs -dEmbedAllFonts=true -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$@ $(basename $<).pdf

compressed : $(PDF:.pdf=.compressed.pdf)

clean :
	latexmk -C *.tex
	rm -rf $(PDF:.pdf=.compressed.pdf) $(PDF:.pdf=.bbl) build _minted-*
