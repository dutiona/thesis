TEX = latexmk --pdf -pdflatex="pdflatex --shell-escape"
SRC = $(filter-out trash.tex paper.old.tex, $(wildcard *.tex))
PDF = $(SRC:.tex=.pdf)

all : $(PDF)

%.pdf : %.tex
	$(TEX) $^ -jobname="$(basename $^)"

.PHONY : clean

clean :
	latexmk -C *.tex
	rm -rf build _minted-*