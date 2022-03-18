PANDOC = pandoc --slide-level=2 --verbose -t beamer -H header.tex -V classoption=svgnames
SRC = $(filter-out trash.md, $(wildcard *.md))
PDF = $(SRC:.md=.pdf)

all: $(PDF) handout compressed html

%.pdf : %.md
	$(PANDOC) $< -o $@

handout :
	$(PANDOC) -V handout slides.md -o slides.handout.pdf
	pdfjam slides.handout.pdf --nup 2x2 --keepinfo \
		--paper letterpaper --frame true --scale 0.9 \
		--suffix "nup"
	mv slides.handout-nup.pdf slides.handout.pdf 

compressed :
	ghostscript -dEmbedAllFonts=true -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=slides.compressed.pdf slides.pdf
	ghostscript -dEmbedAllFonts=true -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=slides.handout.compressed.pdf slides.handout.pdf

html : install
	pandoc --slide-level=2 --verbose -f markdown -t revealjs -s slides.md -o slides.html

install :
	bash ./install_reveal.sh

clean :
	rm -rf $(PDF) $(PDF:.pdf=.compressed.pdf) $(PDF:.pdf=.handout.pdf) $(PDF:.pdf=.handout.compressed.pdf) $(PDF:.pdf=.html) reveal.js build _minted-*

