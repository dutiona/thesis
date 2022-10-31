TEX = latexmk --pdf -pdflatex="pdflatex --shell-escape"
GSCOMPRESS = ghostscript -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dPDFSETTINGS=/printer 
GSEMBEDDED = ghostscript -sDEVICE=pdfwrite -dBATCH -dNOPAUSE -dSAFER \
	-dPDFX -dPDFSETTINGS=/prepress -dPrinted=true \
	-dEmbedAllFonts=true -dSubsetFonts=true \
	-dAutoFilterColorImages=false -dColorImageFilter=/FlateEncode \
	-dAutoFilterGrayImages=false -dGrayImageFilter=/FlateEncode \
	-dAutoFilterMonoImages=false -dMonoImageFilter=/CCITTFaxEncode
SRC = $(filter-out flyleaf.tex trash.tex main.old.tex, $(wildcard *.tex))
DEP = flyleaf.tex ../bibliography.bib $(wildcard chapters/*.tex)
PDF = $(SRC:.tex=.pdf)

all : $(PDF) compressed embedded

%.pdf : %.tex ${DEP}
	$(TEX) $< -jobname="$(basename $<)"
	rm -rf $(basename $<).metadata
	pdftk $@ dump_data_utf8 > $(basename $<).metadata

%.compressed.pdf : %.tex ${DEP}
	$(GSCOMPRESS) -sOutputFile=$@ $(basename $<).pdf

%.embedded.pdf : %.tex ${DEP}
	$(GSEMBEDDED) -sOutputFile=$@ $(basename $<).pdf
	mv $@ $(basename $<).embedded.tmp.pdf
	pdftk "$(basename $<).embedded.tmp.pdf" update_info_utf8 "$(basename $<).metadata" output "$@"
	rm -rf $(basename $<).embedded.tmp.pdf

compressed : $(PDF:.pdf=.compressed.pdf)

embedded : $(PDF:.pdf=.embedded.pdf)

clean :
	latexmk -C *.tex
	rm -rf $(PDF:.pdf=.compressed.pdf) $(PDF:.pdf=.embedded.pdf) $(PDF:.pdf=.metadata) $(PDF:.pdf=.bbl) *.run.xml *.log build _minted-* *.metadata
