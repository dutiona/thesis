TEX = latexmk --pdf -pdflatex="pdflatex --shell-escape"
SRC = $(filter-out trash.tex main.old.tex, $(wildcard *.tex))
PDF = $(SRC:.tex=.pdf)
SUBDIRS = manuscript

all : $(SUBDIRS) $(PDF)

%.pdf : %.tex
	$(TEX) $^ -jobname="$(basename $^)"
	ghostscript -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$(basename $^).compressed.pdf $@

compressed :
	ghostscript -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=manuscript/main.compressed.pdf manuscript/main.pdf

$(SUBDIRS) :
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY : $(SUBDIRS)

clean : subdirclean
	rm -rf $(PDF:.pdf=.final.pdf) $(PDF:.pdf=.bbl) build _minted-*

subdirclean : $(SUBDIRS)
