CAMLC=$(BINDIR)ocamlc
CAMLDEP=$(BINDIR)ocamldep
CAMLLEX=$(BINDIR)ocamllex
CAMLYACC=$(BINDIR)ocamlyacc
# COMPFLAGS=-w A-4-6-9 -warn-error A -g
COMPFLAGS=

EXEC = pcfloop 

# Fichiers compilés, à produire pour fabriquer l'exécutable
SOURCES = pcfast.ml pcfsem.ml  pcfloop.ml 
GENERATED = pcflex.ml pcfparse.ml pcfparse.mli
MLIS =
OBJS = $(GENERATED:.ml=.cmo) $(SOURCES:.ml=.cmo)

# Building the world
all: $(EXEC) Executeur

$(EXEC): $(OBJS)
	$(CAMLC) $(COMPFLAGS) $(OBJS) -o $(EXEC)

.SUFFIXES:
.SUFFIXES: .ml .mli .cmo .cmi .cmx
.SUFFIXES: .mll .mly

.ml.cmo:
	$(CAMLC) $(COMPFLAGS) -c $<

.mli.cmi:
	$(CAMLC) $(COMPFLAGS) -c $<

.mll.ml:
	$(CAMLLEX) $<

.mly.ml:
	$(CAMLYACC) $<

Executeur: 
	gcc $(FLAGS) -o Executeur Executeur.c

# Clean up
clean:
	rm -f *.cm[io] *.cmx *~ .*~ *.o
	rm -f parser.mli
	rm -f $(GENERATED)
	rm -f $(EXEC)
	rm -f Executeur
# rm -f tarball-enonce.tgz tarball-solution.tgz

# Dependencies
depend: $(SOURCES) $(GENERATED) $(MLIS)
	$(CAMLDEP) $(SOURCES) $(GENERATED) $(MLIS) > .depend

include .depend

exec:
	make clean
	make depend
	make
	

# tarball-enonce:
# 	rm -f tarball-enonce.tgz
# 	tar cvzhf tarball-enonce.tgz \
# 		std.pdf Makefile fact.pcf pcfast.ml pcflex.mll pcfloop.ml pcfparse-eleves.mly

# tarball-solution:
# 	rm -f tarball-solution.tgz
# 	tar cvzhf tarball-solution.tgz \
# 		ctd.pdf Makefile fact.pcf pcfast.ml pcflex.mll pcfloop.ml pcfparse.mly
