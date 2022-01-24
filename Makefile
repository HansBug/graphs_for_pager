PLANTUMLCLI  ?= $(shell which plantumlcli)
DOT          ?= $(shell which dot)
RSVG_CONVERT ?= $(shell which rsvg-convert)
INKSCAPE     ?= $(shell which inkscape)
SOURCE       ?= .

PUMLS     := $(shell find ${SOURCE} -name '*.puml')
PUML_PNGS := $(addsuffix .puml.png, $(basename ${PUMLS}))
PUML_SVGS := $(addsuffix .puml.svg, $(basename ${PUMLS}))

GVS     := $(shell find ${SOURCE} -name '*.gv')
GV_PNGS := $(addsuffix .gv.png, $(basename ${GVS}))
GV_SVGS := $(addsuffix .gv.svg, $(basename ${GVS}))

PNGS := ${PUML_PNGS} ${GV_PNGS}
SVGS := ${PUML_SVGS} ${GV_SVGS} $(shell find ${SOURCE} -name '*.svg')
PDFS := $(addsuffix .pdf, $(basename ${SVGS})) $(addsuffix .l.pdf, $(basename ${SVGS}))

all:
	$(MAKE) scripts
	$(MAKE) build

scripts:
	$(MAKE) -f scripts.mk build

build: ${SVGS} ${PNGS} ${PDFS}

tt:
	echo ${PDFS}

%.puml.png: %.puml
	$(PLANTUMLCLI) -t png -o "$(shell readlink -f $@)" "$(shell readlink -f $<)"

%.puml.svg: %.puml
	$(PLANTUMLCLI) -t svg -o "$(shell readlink -f $@)" "$(shell readlink -f $<)"

%.gv.png: %.gv
	$(DOT) -Tpng -o"$(shell readlink -f $@)" "$(shell readlink -f $<)"

%.gv.svg: %.gv
	$(DOT) -Tsvg -o"$(shell readlink -f $@)" "$(shell readlink -f $<)"

%.pdf: %.svg
	$(INKSCAPE) --export-ignore-filters \
		--export-filename="$(shell readlink -f $@)" \
		"$(shell readlink -f $<)"

%.l.pdf: %.svg
	$(RSVG_CONVERT) -f pdf -o "$(shell readlink -f $@)" "$(shell readlink -f $<)"

clean:
	$(MAKE) -f scripts.mk clean
	rm -rf \
		$(shell find ${SOURCE} -name '*.puml.svg') \
		$(shell find ${SOURCE} -name '*.puml.png') \
		$(shell find ${SOURCE} -name '*.gv.svg') \
		$(shell find ${SOURCE} -name '*.gv.png') \
		$(shell find ${SOURCE} -name '*.pdf')

