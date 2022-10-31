TEX = latexmk --pdf -pdflatex="pdflatex --shell-escape"
SRC = $(filter-out flyleaf.tex trash.tex main.old.tex, $(wildcard *.tex))
DEP = flyleaf.tex ../bibliography.bib $(wildcard chapters/*.tex)
PDF = $(SRC:.tex=.pdf)

all : $(PDF) compressed embedded

%.pdf : %.tex ${DEP}
	$(TEX) $< -jobname="$(basename $<)"

%.compressed.pdf : %.tex ${DEP}
	ghostscript -dEmbedAllFonts=true -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$@ $(basename $<).pdf

%.embedded.pdf : %.tex ${DEP}
	ghostscript -sDEVICE=pdfwrite -dBATCH -dNOPAUSE -dSAFER \
	-dPDFX -dPDFSETTINGS=/prepress \
	-dAutoFilterColorImages=false -dColorImageFilter=/FlateEncode \
	-dAutoFilterGrayImages=false -dGrayImageFilter=/FlateEncode \
	-dAutoFilterMonoImages=false -dMonoImageFilter=/CCITTFaxEncode \
	-sOutputFile=$@ $(basename $<).pdf

compressed : $(PDF:.pdf=.compressed.pdf)

embedded : $(PDF:.pdf=.embedded.pdf)

clean :
	latexmk -C *.tex
	rm -rf $(PDF:.pdf=.compressed.pdf) $(PDF:.pdf=.bbl) build _minted-*
