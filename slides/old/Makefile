#PANDOC = pandoc --slide-level=2 --citeproc --pdf-engine-opt=-shell-escape --bibliography=../bibliography.bib --verbose -t beamer -H header.tex -V classoption=svgnames
PANDOC = pandoc --slide-level=2 --pdf-engine-opt=-shell-escape --bibliography=../bibliography.bib --verbose -t beamer -H header.tex -V classoption=svgnames
SRC = $(filter-out trash.md, $(wildcard *.md))
PDF = $(SRC:.md=.pdf)

all : $(PDF) handout compressed #web

%.pdf : %.md header.tex Makefile
	$(PANDOC) $< -o $@

%.handout.pdf : %.md
	$(PANDOC) -V handout $< -o $@
	pdfjam $@ --nup 2x3 --keepinfo \
		--paper letterpaper --frame true --scale 0.9 \
		--suffix "nup"
	mv $(basename $@)-nup.pdf $@

handout : $(PDF:.pdf=.handout.pdf)

%.html : %.md
	pandoc --slide-level=2 --verbose -f markdown -t revealjs -s $< -o $@

web : install $(PDF:.pdf=.html)

%.compressed.pdf : %.md
	ghostscript -dEmbedAllFonts=true -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$@ $(basename $^).pdf

%.handout.compressed.pdf : %.md
	ghostscript -dEmbedAllFonts=true -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$@ $(basename $^).handout.pdf

compressed : $(PDF:.pdf=.compressed.pdf) $(PDF:.pdf=.handout.compressed.pdf)

install :
	bash ./install_reveal.sh

clean :
	latexmk -C *.tex
	rm -rf $(PDF) $(PDF:.pdf=.compressed.pdf) $(PDF:.pdf=.handout.pdf) $(PDF:.pdf=.handout.compressed.pdf) $(PDF:.pdf=.html) reveal.js build _minted-*

