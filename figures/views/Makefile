TEX = latexmk --pdf -pdflatex="pdflatex --shell-escape"
SRC = $(filter-out trash.tex paper.old.tex, $(wildcard *.tex))
PDF = $(SRC:.tex=.pdf)
SUBDIRS = eq

all : $(SUBDIRS) $(PDF)

%.pdf : %.tex
	$(TEX) $^ -jobname="$(basename $^)"

$(SUBDIRS) :
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY : $(SUBDIRS)

clean : subdirclean
	latexmk -C *.tex
	rm -rf build _minted-*

subdirclean : $(SUBDIRS)
