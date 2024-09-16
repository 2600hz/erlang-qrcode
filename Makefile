PROJECT := qrcode
SOURCES := $(wildcard src/*.erl)
MODULE_NAMES := $(sort $(foreach module,$(SOURCES),$(shell basename $(module) .erl)))
MODULES := $(shell echo $(MODULE_NAMES) | sed 's/ /,/g')
EBIN = ebin

.PHONY=compile
compile: $(EBIN) $(EBIN)/$(PROJECT).app

$(EBIN)/$(PROJECT).app:
	@erl -make
	@sed "s/{modules,\s*\[\]}/{modules, \[$(MODULES)\]}/" src/$(PROJECT).app.src > $@

$(EBIN):
	@mkdir -p ebin

clean:
	@rm -f ebin/*
