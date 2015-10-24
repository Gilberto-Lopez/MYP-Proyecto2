SUBDIRS = src
EXTRA_DIST = autogen.sh

ACLOCAL_AMFLAGS = -I m4
#
compile: 
	cd $(top_srcdir) && valac src/*.vala -o main $(VALAFLAGS) --disable-warnings
run: compile
	cd $(top_srcdir) && ./main lib/DataBase.db lib/DataBaseUI.glade
#
if HAVE_VALADOC
docs:
	cd $(top_srcdir) && valadoc -o doc src/*.vala $(VALAFLAGS)

else
docs:
	echo "No se encontró valadoc: la documentación no puede generarse.";
endif

clean-local: clean-docs

clean-docs:
	rm -rf $(top_srcdir)/doc

CLEANFILES = src/*.h src/*.c src/*.vapi src/*.stamp $(top_srcdir)/main
