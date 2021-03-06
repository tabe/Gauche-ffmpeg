dnl
dnl Configuring Gauche-ffmpeg
dnl  process this file with autoconf to generate 'configure'.
dnl $Id$
dnl

AC_PREREQ(2.54)
AC_INIT(Gauche-ffmpeg, 0.2.0, tabe@fixedpoint.jp)
dnl If you want to use the system name (OS, architecture, etc) in the
dnl configure, uncomment the following line.  In such a case, you need
dnl to copy config.guess and config.sub from automake distribution.
dnl AC_CANONICAL_SYSTEM

dnl Set up gauche related commands.  The commands are set by scanning
dnl PATH.  You can override them by "GOSH=/my/gosh ./configure" etc.
AC_PATH_PROG([GOSH], gosh)
AC_PATH_PROG([GAUCHE_CONFIG], gauche-config)
AC_PATH_PROG([GAUCHE_PACKAGE], gauche-package)
AC_PATH_PROG([GAUCHE_INSTALL], gauche-install)
AC_PATH_PROG([GAUCHE_CESCONV], gauche-cesconv)

dnl Usually these parameters are set by AC_PROG_CC, but we'd rather use
dnl the same one as Gauche has been compiled with.
SOEXT=`$GAUCHE_CONFIG --so-suffix`
OBJEXT=`$GAUCHE_CONFIG --object-suffix`
EXEEXT=`$GAUCHE_CONFIG --executable-suffix`
AC_SUBST(SOEXT)
AC_SUBST(OBJEXT)
AC_SUBST(EXEEXT)

dnl Check for headers.
dnl Add your macro calls to check required headers, if you have any.

dnl Check for other programs.
dnl Add your macro calls to check existence of programs, if you have any.
AC_PROG_CC
AC_PROG_CPP

AC_CHECK_PROG([BASENAME], [basename], [basename], [])
if test "x$BASENAME" = "x"; then
  BASENAME='echo no action: wget'
  AC_SUBST(BASENAME)
fi

AC_CHECK_PROGS([WGET], [wget curl], AC_MSG_WARN([no ftp client found]))
if test "x$WGET" = "xcurl"; then
  WGET='curl -O'
  AC_SUBST(WGET)
elif test "x$WGET" = "x"; then
  WGET='echo'
  AC_SUBST(WGET)
fi

dnl Check for libraries
dnl Add your macro calls to check required libraries, if you have any.
PKG_CHECK_MODULES([LIBAVCODEC], [libavcodec])
PKG_CHECK_MODULES([LIBAVFORMAT], [libavformat])
PKG_CHECK_MODULES([LIBAVDEVICE], [libavdevice])

dnl Creating gpd (gauche package description) file
GAUCHE_PACKAGE_CONFIGURE_ARGS="`echo ""$ac_configure_args"" | sed 's/[\\""\`\$]/\\\&/g'`"
AC_MSG_NOTICE([creating ${PACKAGE_NAME}.gpd])
$GAUCHE_PACKAGE make-gpd "$PACKAGE_NAME" \
  -version "$PACKAGE_VERSION" \
  -configure "./configure $GAUCHE_PACKAGE_CONFIGURE_ARGS"

dnl Output
echo -n $PACKAGE_VERSION > VERSION
AC_OUTPUT(Makefile test/Makefile doc/Makefile example/Makefile)
