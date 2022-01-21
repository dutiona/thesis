TEX = latexmk --pdf -pdflatex="pdflatex --shell-escape"
SRC = $(filter-out trash.tex main.old.tex, $(wildcard *.tex))
PDF = $(SRC:.tex=.pdf)
SUBDIRS = figs

all : $(SUBDIRS) $(PDF)

%.pdf : %.tex
	$(TEX) $^ -jobname="$(basename $^)"
	ghostscript -dEmbedAllFonts=true -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$(basename $^).compressed.pdf $@

compressed :
	ghostscript -dEmbedAllFonts=true -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=main.compressed.pdf main.pdf

$(SUBDIRS) :
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY : $(SUBDIRS)

clean : subdirclean
	latexmk -C *.tex
	rm -rf $(PDF:.pdf=.final.pdf) $(PDF:.pdf=.bbl) build _minted-*

subdirclean : $(SUBDIRS)
