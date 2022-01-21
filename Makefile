PLANTUMLCLI  ?= $(shell which plantumlcli)
DOT          ?= $(shell which dot)
RSVG_CONVERT ?= $(shell which rsvg-convert)
SOURCE       ?= .

PUMLS     := $(shell find ${SOURCE} -name *.puml)
PUML_PNGS := $(addsuffix .puml.png, $(basename ${PUMLS}))
PUML_SVGS := $(addsuffix .puml.svg, $(basename ${PUMLS}))

GVS     := $(shell find ${SOURCE} -name *.gv)
GV_PNGS := $(addsuffix .gv.png, $(basename ${GVS}))
GV_SVGS := $(addsuffix .gv.svg, $(basename ${GVS}))

PNGS := ${PUML_PNGS} ${GV_PNGS}
SVGS := ${PUML_SVGS} ${GV_SVGS}
PDFS := $(addsuffix .pdf, $(basename ${SVGS}))

all: build

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
	$(RSVG_CONVERT) -f pdf -o "$(shell readlink -f $@)" "$(shell readlink -f $<)"

clean:
	rm -rf \
		$(shell find ${SOURCE} -name *.puml.svg) \
		$(shell find ${SOURCE} -name *.puml.png) \
		$(shell find ${SOURCE} -name *.gv.svg) \
		$(shell find ${SOURCE} -name *.gv.png) \

