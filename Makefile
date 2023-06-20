
MAKESUBDIRS=lib-sexp pa common

INCLUDES=-I common
# commons.cma now depends on multiple libs :(
LIBS=common/common.cma
SYSLIBS=unix.cma str.cma

all:
	$(MAKE) rec 
	$(MAKE) ocamltarzan
opt: 
	$(MAKE) rec.opt

# -unsafe-string not anymore available in 4.12
ocamltarzan: ocamltarzan.ml
	ocamlc -o $@ -custom $(INCLUDES) $(SYSLIBS) $(LIBS) $^
clean::
	rm -f ocamltarzan

rec:
	set -e; for i in $(MAKESUBDIRS); do $(MAKE) -C $$i all; done 
rec.opt:
	set -e; for i in $(MAKESUBDIRS); do $(MAKE) -C $$i all.opt; done 

clean::
	rm -f *.cm[iox] *.o *.a *.cma *.cmxa *.annot

clean::
	set -e; for i in $(MAKESUBDIRS); do $(MAKE) -C $$i clean; done 
depend::
	set -e; for i in $(MAKESUBDIRS); do $(MAKE) -C $$i depend; done
distclean::
	set -e; for i in $(MAKESUBDIRS); do $(MAKE) -C $$i distclean; done 

test:
	echo "testing tof"
	./ocamltarzan -choice tof tests/expr.ml
	echo "testing vof"
	./ocamltarzan -choice vof tests/expr.ml
