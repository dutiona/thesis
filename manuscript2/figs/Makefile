TEX = latexmk --pdf -pdflatex="pdflatex --shell-escape"
SRC = $(filter-out trash.tex, $(wildcard *.tex))
PDF = $(SRC:.tex=.pdf)
SUBDIRS = views

all : $(SUBDIRS) $(PDF)

%.pdf : %.tex
	$(TEX) $^ -jobname="$(basename $^)"

$(SUBDIRS) :
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY : $(SUBDIRS)

clean : subdirclean
	latexmk -C *.tex
	rm -rf $(PDF:.pdf=.bbl)

subdirclean : $(SUBDIRS)
