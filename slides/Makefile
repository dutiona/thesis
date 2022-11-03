TEX = latexmk --pdf -pdflatex="pdflatex --shell-escape"
GSCOMPRESS = ghostscript -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dPDFSETTINGS=/printer
GSEMBEDDED = ghostscript -sDEVICE=pdfwrite -dBATCH -dNOPAUSE -dSAFER \
	-dPDFX -dPDFSETTINGS=/prepress -dPrinted=true \
	-dEmbedAllFonts=true -dSubsetFonts=true \
	-dAutoFilterColorImages=false -dColorImageFilter=/FlateEncode \
	-dAutoFilterGrayImages=false -dGrayImageFilter=/FlateEncode \
	-dAutoFilterMonoImages=false -dMonoImageFilter=/CCITTFaxEncode
SRC = $(filter-out header.tex, $(wildcard *.tex))
PDF = $(SRC:.tex=.pdf)
PDFNOTE = $(PDF:.pdf=.pdfpc)

all: $(PDF) $(PDFNOTE) handout compressed embedded

%.pdf : %.tex Makefile
	$(TEX) $< -jobname="$(basename $<)"
	rm -rf $(basename $<).metadata
#	pdftk $@ dump_data_utf8 > $(basename $<).metadata

%.pdfpc : %.pdf
	sed -i 's/\\\\/\n/g' $(basename $<).pdfpc
	sed -i 's/\\par/\n\n/g' $(basename $<).pdfpc

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
#	mv $@ $(basename $<).embedded.tmp.pdf
#	pdftk "$(basename $<).embedded.tmp.pdf" update_info_utf8 "$(basename $<).metadata" output "$@"
#	rm -rf $(basename $<).embedded.tmp.pdf

%.handout.embedded.pdf : %.tex ${DEP}
	$(GSEMBEDDED) -sOutputFile=$@ $(basename $<).handout.pdf

compressed : $(PDF:.pdf=.compressed.pdf) $(PDF:.pdf=.handout.compressed.pdf)

embedded : $(PDF:.pdf=.embedded.pdf) $(PDF:.pdf=.handout.embedded.pdf)

clean :
	latexmk -C *.tex
	rm -rf $(PDF) $(PDF:.pdf=.compressed.pdf) $(PDF:.pdf=.handout.pdf) $(PDF:.pdf=.handout.compressed.pdf) $(PDF:.pdf=.embedded.pdf) $(PDF:.pdf=.handout.embedded.pdf) *.bbl *.run.xml *.nav *.snm *.vrb *.upa build _minted-* *.metadata

