PANDOC = pandoc --slide-level=2 --citeproc --pdf-engine-opt=-shell-escape --bibliography=../bibliography.bib --verbose -t beamer -H header.tex -V classoption=svgnames
TEX = latexmk --pdf -pdflatex="pdflatex --shell-escape"
SRC = $(filter-out trash.md, $(wildcard *.md))
SRC2 = $(filter-out header.tex, $(wildcard *.tex))
PDF = $(SRC:.md=.pdf)
PDF2 = $(SRC2:.tex=.pdf)

all: $(PDF) $(PDF2) handout compressed #web

%.pdf : %.md header.tex Makefile
	$(PANDOC) $< -o $@

%.pdf : %.tex
	$(TEX) $< -jobname="$(basename $<)"

%.handout.pdf : %.md
	$(PANDOC) -V handout $< -o $@
	pdfjam $@ --nup 2x2 --keepinfo \
		--paper letterpaper --frame true --scale 0.9 \
		--suffix "nup"
	mv $(basename $@)-nup.pdf $@

%.handout.pdf : %.tex
	cp $(basename $<).pdf $@
	pdfjam $@ --nup 2x2 --keepinfo \
		--paper letterpaper --frame true --scale 0.9 \
		--suffix "nup"
	mv $(basename $@)-nup.pdf $@

handout : $(PDF:.pdf=.handout.pdf) $(PDF2:.pdf=.handout.pdf)

%.html : %.md
	pandoc --slide-level=2 --verbose -f markdown -t revealjs -s $< -o $@

web : install $(PDF:.pdf=.html)

%.compressed.pdf : %.md
	ghostscript -dEmbedAllFonts=true -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$@ $(basename $^).pdf

%.handout.compressed.pdf : %.md
	ghostscript -dEmbedAllFonts=true -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$@ $(basename $^).handout.pdf

%.compressed.pdf : %.tex
	ghostscript -dEmbedAllFonts=true -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$@ $(basename $^).pdf

%.handout.compressed.pdf : %.tex
	ghostscript -dEmbedAllFonts=true -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$@ $(basename $^).handout.pdf

compressed : $(PDF:.pdf=.compressed.pdf) $(PDF:.pdf=.handout.compressed.pdf) $(PDF2:.pdf=.compressed.pdf) $(PDF2:.pdf=.handout.compressed.pdf)

install :
	bash ./install_reveal.sh

clean :
	latexmk -C *.tex
	rm -rf $(PDF2) $(PDF2:.pdf=.compressed.pdf) $(PDF2:.pdf=.handout.pdf) $(PDF2:.pdf=.handout.compressed.pdf) *.nav *.snm *.vrb build _minted-*
	rm -rf $(PDF) $(PDF:.pdf=.compressed.pdf) $(PDF:.pdf=.handout.pdf) $(PDF:.pdf=.handout.compressed.pdf) $(PDF:.pdf=.html) reveal.js build _minted-*

