SRC= \
  common.ml \
  common2.ml

TARGET=common
TARGETPACK=commonlib

INCLUDES=
SYSLIBS= str.cma unix.cma bigarray.cma

#dont use -custom, it makes the bytecode unportable.
OCAMLCFLAGS= -g -dtypes # -w A

# This flag is also used in subdirectories so don't change its name here.
OPTFLAGS=

OCAMLC=ocamlc$(OPTBIN) $(OCAMLCFLAGS)  $(INCLUDES)  $(SYSINCLUDES) -thread
OCAMLOPT=ocamlopt$(OPTBIN) $(OPTFLAGS) $(INCLUDES) $(SYSINCLUDES) -thread
OCAMLDEP=ocamldep $(INCLUDES)

OBJS = $(SRC:.ml=.cmo)
OPTOBJS = $(SRC:.ml=.cmx)

all: $(TARGET).cma $(TARGETPACK).cmo
all.opt: $(TARGET).cmxa

$(TARGET).cma: $(OBJS)
	$(OCAMLC) -a -o $(TARGET).cma $(OBJS)

$(TARGET).cmxa: $(OPTOBJS) $(LIBS:.cma=.cmxa)
	$(OCAMLOPT) -a -o $(TARGET).cmxa $(OPTOBJS)

$(TARGETPACK).cmo: $(OBJS)
	$(OCAMLC) -pack -o $(TARGETPACK).cmo $(OBJS)

.SUFFIXES: .ml .mli .cmo .cmi .cmx

.ml.cmo:
	$(OCAMLC) -c $<
.mli.cmi:
	$(OCAMLC) -c $<
.ml.cmx:
	$(OCAMLOPT) -c $<

.ml.mldepend: 
	$(OCAMLC) -i $<

depend:
	$(OCAMLDEP) *.mli *.ml >.depend

clean:
	$(RM) *.cm[ioxa] *.o *.a *.cmxa *.annot *~ .*~ gmon.out #*#

distclean:
	$(RM) .depend

.PHONY: depend clean distclean

-include .depend
