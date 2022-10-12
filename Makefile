BUNDLE_DIR = roynard.thesis.2022
SUBDIRS = figures manuscript slides

all : $(SUBDIRS) bundle

${BUNDLE_DIR}.tar.gz : $(SUBDIRS)
	mkdir -p ${BUNDLE_DIR}
	cp -f manuscript/manuscript.compressed.pdf ${BUNDLE_DIR}/manuscript.pdf
	cp -f manuscript/long_summary_fr_standalone.compressed.pdf ${BUNDLE_DIR}/resume_long.pdf
	cp -f manuscript/long_summary_en_standalone.compressed.pdf ${BUNDLE_DIR}/long_summary.pdf
	cp -f slides/slides.compressed.pdf ${BUNDLE_DIR}/slides.pdf
	cp -f slides/slides_remake.compressed.pdf ${BUNDLE_DIR}/slides_remake.pdf
	cp -f slides/slides.handout.compressed.pdf ${BUNDLE_DIR}/handout.pdf
	cp -f slides/slides_remake.handout.compressed.pdf ${BUNDLE_DIR}/remake.handout.pdf
	tar cvzf ${BUNDLE_DIR}.tar.gz ${BUNDLE_DIR}

bundle : ${BUNDLE_DIR}.tar.gz

$(SUBDIRS) :
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY : $(SUBDIRS)

clean : subdirclean
	rm -rf ${BUNDLE_DIR} ${BUNDLE_DIR}.tar.gz

subdirclean : $(SUBDIRS)
