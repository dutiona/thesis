BUNDLE_DIR = roynard.thesis.2022
SUBDIRS = figures manuscript slides
INE = 1600008776Z
CDROM = cdrom/these_archivage_${INE}

all : $(SUBDIRS) bundle

${BUNDLE_DIR}.tar.gz : $(SUBDIRS)
	mkdir -p ${BUNDLE_DIR}
	cp -f manuscript/manuscript.embedded.pdf ${BUNDLE_DIR}/manuscript.pdf
	cp -f manuscript/long_summary_fr_standalone.embedded.pdf ${BUNDLE_DIR}/resume_long.pdf
	cp -f manuscript/long_summary_en_standalone.embedded.pdf ${BUNDLE_DIR}/long_summary.pdf
	cp -f slides/slides.embedded.pdf ${BUNDLE_DIR}/slides.pdf
	cp -f slides/slides.handout.embedded.pdf ${BUNDLE_DIR}/handout.pdf
	tar cvzf ${BUNDLE_DIR}.tar.gz ${BUNDLE_DIR}

bundle : ${BUNDLE_DIR}.tar.gz

cdrom :
	mkdir -p ${CDROM}
	cp  ./subject_en.txt cdrom/sujet_traduit_${INE}.txt
	cp  ./subject_fr.txt cdrom/sujet_${INE}.txt
	cp  ./keywords_fr.txt cdrom/motscles_${INE}.txt
	cp  ./manuscript/abstract_en.txt cdrom/resume_en_${INE}.txt
	cp  ./manuscript/abstract_fr.txt cdrom/resume_fr_${INE}.txt
	cp -R ./assets ${CDROM}
	cp -R ./figures ${CDROM}
	cp -R ./images ${CDROM}
	cp -R ./manuscript ${CDROM}
	cp ./bibliography.bib ${CDROM}
	cp ./Makefile.cdrom ${CDROM}/Makefile
	$(MAKE) -C ${CDROM}
	cp ${CDROM}/${BUNDLE_DIR}/manuscript.pdf cdrom/these_archivage_${INE}.pdf
	$(MAKE) -C ${CDROM} clean
	rm -rf ${CDROM}/*/*.run.xml ${CDROM}/*/indent.log ${CDROM}/*/pdfa.xmpi

$(SUBDIRS) :
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY : $(SUBDIRS) cdrom

clean : subdirclean
	rm -rf ${BUNDLE_DIR} ${BUNDLE_DIR}.tar.gz
	rm -rf cdrom

subdirclean : $(SUBDIRS)
