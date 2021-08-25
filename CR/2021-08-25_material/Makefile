PANDOC = pandoc -s -V geometry:margin=1in
SRC = $(wildcard *.md)
PDF = $(SRC:.md=.pdf)

all : $(PDF)

%.pdf : %.md
	$(PANDOC) -o $(basename $^).pdf $^
	ghostscript -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$(basename $^).compressed.pdf $@

clean : subdirclean
	rm -rf $(PDF)
