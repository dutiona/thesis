TEX = latexmk --pdf -pdflatex="pdflatex --shell-escape"
SRC = $(filter-out trash.tex main.old.tex, $(wildcard *.tex))
PDF = $(SRC:.tex=.pdf)

all : $(PDF) compressed

%.pdf : %.tex
	$(TEX) $^ -jobname="$(basename $^)"

%.compressed.pdf : %.tex
	ghostscript -dEmbedAllFonts=true -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$@ $(basename $^).pdf

compressed : $(PDF:.pdf=.compressed.pdf)

clean :
	latexmk -C *.tex
	rm -rf $(PDF:.pdf=.compressed.pdf) $(PDF:.pdf=.bbl) build _minted-*
