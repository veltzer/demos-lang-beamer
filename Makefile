##############
# parameters #
##############
# do you want to show the commands executed ?
DO_MKDBG:=0
# do you want dependency on the makefile itself ?!?
DO_ALLDEP:=1
# do you want to do 'html' from 'mkd'?
DO_FMT_MKD_HTM:=1
# do you want to do 'pdf' from 'mkd'?
DO_FMT_MKD_PDF:=1
# do you want to do 'pdf' from 'tex'?
DO_FMT_TEX_PDF:=1
# do you want to do 'pdf' from 'txt'?
DO_FMT_TXT_PDF:=1
# do spell check on all?
DO_MD_ASPELL:=1

########
# code #
########
# UNOPATH=UNOPATH="$(shell ls -d /opt/libreoffice*)"
# UNOPYTHON=$(UNOPATH)/program/python
UNOPATH=
UNOPYTHON=/usr/bin/python
UNOTIMEOUT=30
UNOWARNINGS=PYTHONWARNINGS="ignore::DeprecationWarning"

ALL:=

# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

# beamer
TEX_SRC:=$(shell find src -type f -and -name "*.tex")
TEX_BAS:=$(basename $(TEX_SRC))
TEX_PDF:=$(addprefix out/,$(addsuffix .pdf,$(TEX_BAS)))

ifeq ($(DO_MD_ASPELL),1)
ALL+=$(MD_ASPELL)
endif # DO_MD_ASPELL

ifeq ($(DO_FMT_ODP_PPT),1)
ALL+=$(ODP_PPT)
endif # DO_FMT_ODP_PPT

ifeq ($(DO_FMT_ODP_PDF),1)
ALL+=$(ODP_PDF)
endif # DO_FMT_ODP_PDF

ifeq ($(DO_FMT_TEX_PDF),1)
ALL+=$(TEX_PDF)
endif # DO_FMT_TEX_PDF

ifeq ($(DO_FMT_TXT_PDF),1)
ALL+=$(TXT_PDF)
endif # DO_FMT_TXT_PDF

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	@true

.PHONY: all_mkd
all_mkd: $(MKD_HTM)

.PHONY: all_beamer
all_beamer: $(TEX_PDF)

.PHONY: debug
debug:
	$(info doing [$@])
	$(info UNOPATH is $(UNOPATH))
	$(info UNOPYTHON is $(UNOPYTHON))
	$(info ALL is $(ALL))
	$(info ODP_SRC is $(ODP_SRC))
	$(info ODP_PPT is $(ODP_PPT))
	$(info ODP_PDF is $(ODP_PDF))
	$(info MKD_SRC is $(MKD_SRC))
	$(info MKD_HTM is $(MKD_HTM))
	$(info MKD_PDF is $(MKD_PDF))
	$(info TEX_SRC is $(TEX_SRC))
	$(info TEX_HTM is $(TEX_HTM))
	$(info TXT_SRC is $(TXT_SRC))
	$(info TXT_PDF is $(TXT_PDF))
	$(info MD_SRC is $(MD_SRC))
	$(info MD_BAS is $(MD_BAS))
	$(info MD_ASPELL is $(MD_ASPELL))
	$(info MD_MDL is $(MD_MDL))

.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)rm -f $(ALL)

.PHONY: clean_hard
clean_hard:
	$(info doing [$@])
	$(Q)git clean -qffxd

.PHONY: spell_many
spell_many:
	$(info doing [$@])
	$(Q)aspell_many.sh $(MD_SRC)

############
# patterns #
############
$(TEX_PDF): out/%.pdf: %.tex
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)pymakehelper wrapper_pdflatex --input_file $< --output_file $@

##########
# alldep #
##########
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif # DO_ALLDEP
