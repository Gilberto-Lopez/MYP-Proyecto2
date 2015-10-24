AC_INIT([proyecto2],[1.0])
AC_CONFIG_AUX_DIR([build])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE
AM_SILENT_RULES([yes])
AM_PROG_LIBTOOL
LT_INIT
AC_PROG_CC
AC_PROG_CC_C_O
AM_PROG_VALAC
#pkg_modules = "glib-2.0 >= 2.44.1
#		gmodule-2.0 >= 2.44.1
#		gtk+-3.0 >= 3.16.7
#		sqlite3 >= 3.9.0"
#PKG_CHECK_MODULES([PROYECTO2], [$pkg_modules])
#AC_SUBST(PROYECTO2_CFLAGS)
#AC_SUBST(PROYECTO2_LIBS)
AC_CHECK_PROGS([VALADOC], [valadoc])
AS_IF([test -z "$VALADOC"],
      [have_valadoc=no],
      [have_valadoc=yes])
AS_IF([test "x$have_valadoc" = "xno"],
      [AC_MSG_WARN([Valadoc no encontrado - no se generará la documentación]) ])
AM_CONDITIONAL([HAVE_VALADOC], 
               [test -n "$VALADOC"])
AC_SUBST(VALAFLAGS, ["--pkg gtk+-3.0 --pkg gmodule-2.0 --pkg sqlite3"])
AC_CONFIG_FILES([Makefile
		src/Makefile])
AC_OUTPUT
