BUNDLE_DIR = "roynard.thesis.2022"
SUBDIRS = figures manuscript slides

all : $(SUBDIRS) bundle

${BUNDLE_DIR}.tar.gz : $(SUBDIRS)
	mkdir -p ${BUNDLE_DIR}
	cp -f manuscript/main.compressed.pdf ${BUNDLE_DIR}/manuscript.pdf
	cp -f slides/slides.compressed.pdf ${BUNDLE_DIR}/slides.pdf
	cp -f slides/slides.handout.compressed.pdf ${BUNDLE_DIR}/handout.pdf
	tar cvzf ${BUNDLE_DIR}.tar.gz ${BUNDLE_DIR}

bundle : ${BUNDLE_DIR}.tar.gz

$(SUBDIRS) :
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY : $(SUBDIRS)

clean : subdirclean
	rm -rf ${BUNDLE_DIR} ${BUNDLE_DIR}.tar.gz

subdirclean : $(SUBDIRS)
