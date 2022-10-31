GSCOMPRESS = ghostscript -dEmbedAllFonts=true -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH
GSEMBEDDED = ghostscript -sDEVICE=pdfwrite -dBATCH -dNOPAUSE -dSAFER \
	-dPDFX -dPDFSETTINGS=/prepress -dPrinted=true \
	-dEmbedAllFonts=true -dSubsetFonts=true \
	-dAutoFilterColorImages=false -dColorImageFilter=/FlateEncode \
	-dAutoFilterGrayImages=false -dGrayImageFilter=/FlateEncode \
	-dAutoFilterMonoImages=false -dMonoImageFilter=/CCITTFaxEncode
TEX = latexmk --pdf -pdflatex="pdflatex --shell-escape"
SRC = $(filter-out header.tex, $(wildcard *.tex))
PDF = $(SRC:.tex=.pdf)

all: $(PDF) handout compressed embedded

%.pdf : %.tex Makefile
	$(TEX) $< -jobname="$(basename $<)"

%.handout.pdf : %.tex
	cp $(basename $<).pdf $@
	pdfjam $@ --nup 2x3 --keepinfo \
		--paper letterpaper --frame true --scale 0.9 \
		--suffix "nup"
	mv $(basename $@)-nup.pdf $@

handout : $(PDF:.pdf=.handout.pdf)

%.compressed.pdf : %.tex
	$(GSCOMPRESS) -sOutputFile=$@ $(basename $^).pdf

%.handout.compressed.pdf : %.tex
	$(GSCOMPRESS) -sOutputFile=$@ $(basename $^).handout.pdf

%.embedded.pdf : %.tex ${DEP}
	$(GSEMBEDDED) -sOutputFile=$@ $(basename $<).pdf

%.handout.embedded.pdf : %.tex ${DEP}
	$(GSEMBEDDED) -sOutputFile=$@ $(basename $<).handout.pdf

compressed : $(PDF:.pdf=.compressed.pdf) $(PDF:.pdf=.handout.compressed.pdf)

embedded : $(PDF:.pdf=.embedded.pdf) $(PDF:.pdf=.handout.embedded.pdf)

clean :
	latexmk -C *.tex
	rm -rf $(PDF) $(PDF:.pdf=.compressed.pdf) $(PDF:.pdf=.handout.pdf) $(PDF:.pdf=.handout.compressed.pdf) *.bbl *.run.xml *.nav *.snm *.vrb build _minted-*

