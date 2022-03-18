TEX = latexmk --pdf -pdflatex="pdflatex --shell-escape"
SRC = $(filter-out trash.tex main.old.tex, $(wildcard *.tex))
PDF = $(SRC:.tex=.pdf)

all : $(PDF) compressed

%.pdf : %.tex
	$(TEX) $^ -jobname="$(basename $^)"

compressed :
	ghostscript -dEmbedAllFonts=true -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=main.compressed.pdf main.pdf

clean :
	latexmk -C *.tex
	rm -rf $(PDF:.pdf=.compressed.pdf) $(PDF:.pdf=.bbl) build _minted-*
