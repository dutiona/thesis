TEX = latexmk --pdf -pdflatex="pdflatex --shell-escape"
SRC = $(filter-out trash.tex main.old.tex, $(wildcard *.tex))
PDF = $(SRC:.tex=.pdf)
BUNDLE_DIR = "roynard.thesis.2022"
SUBDIRS = figures manuscript slides

all : $(SUBDIRS) $(PDF) compressed bundle

%.pdf : %.tex
	$(TEX) $^ -jobname="$(basename $^)"

compressed :
	ghostscript -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=manuscript/main.compressed.pdf manuscript/main.pdf
	ghostscript -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=slides/slides.compressed.pdf slides/slides.pdf
	ghostscript -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=slides/slides.handout.compressed.pdf slides/slides.handout.pdf

bundle :
	mkdir -p ${BUNDLE_DIR}
	cp manuscript/main.compressed.pdf ${BUNDLE_DIR}/manuscript.pdf
	cp slides/slides.compressed.pdf ${BUNDLE_DIR}/slides.pdf
	cp slides/slides.handout.compressed.pdf ${BUNDLE_DIR}/handout.pdf
	tar cvzf ${BUNDLE_DIR}.tar.gz ${BUNDLE_DIR}
	rm -rf ${BUNDLE_DIR}

$(SUBDIRS) :
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY : $(SUBDIRS) compressed

clean : subdirclean
	rm -rf $(PDF:.pdf=.final.pdf) $(PDF:.pdf=.bbl) ${BUNDLE_DIR}.tar.gz build _minted-*

subdirclean : $(SUBDIRS)
