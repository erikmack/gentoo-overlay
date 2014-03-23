# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A game engine, a framework for 3D rendering and game development for Python and C++ programs."
HOMEPAGE="http://www.panda3d.org/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
games-engines/panda3d-ppremake
x11-libs/libX11
dev-libs/openssl
x11-libs/libXrandr
x11-libs/libXcursor
media-libs/freetype
media-libs/libvorbis
virtual/jpeg
media-libs/libpng
media-libs/tiff
media-libs/openal
virtual/opengl
media-libs/mesa
media-libs/libvorbis
dev-libs/libtar
sys-libs/zlib
dev-libs/libRocket
dev-libs/boost[python]
"
# librocket requires boost[python]

inherit cvs

ECVS_AUTH="pserver"
ECVS_USER="anonymous"
ECVS_SERVER="panda3d.cvs.sourceforge.net:/cvsroot/panda3d"
ECVS_MODULE="panda3d"
ECVS_PASS=""
#ECVS_CVS_OPTIONS="-z3"

S="${WORKDIR}/panda3d/dtool"

src_prepare() {
	epatch "${FILESDIR}/${P}-honor-destdir.patch"
	epatch "${FILESDIR}/${P}-dedicated-headers-dir.patch"
	epatch "${FILESDIR}/${P}-etc-subdir.patch"
	epatch "${FILESDIR}/${P}-test-install-dirs.patch"

	# TODO: patch to replace hardcoded 'make' with '$(MAKE)' 
	# so that e.g. MAKEOPTS are honored
}

_use_configure() {
	local useflag ppvar

	ppvar=$1
	useflag=$2

	if [ -n "$useflag" ] && use $useflag; then
		_static_configure $ppvar 1
	else
		_static_configure $ppvar
	fi
}

_static_configure() {
	local useflag ppvar

	ppvar=$1
	value=$2

	echo "#define $ppvar $value" >>Config.pp
}

src_configure() {

	pushd ..

	# Otherwise it tries /usr/etc
	_static_configure INSTALL_CONFIG_DIR /etc/panda3d
	_static_configure INSTALL_IGATEDB_DIR /etc/panda3d

	# Default looks for libboost_python.so, but Gentoo installs
	# with suffix (e.g. -2.7, -3.3)
	echo "#define ROCKET_LIBS RocketCore RocketDebugger boost_python-2.7" >>Config.pp

	# There are just a few optional deps :-)
	# We must be careful to explicitly set or unset every one that has
	# a "libtest" in dtool/Config.pp, or the package will
	# automagically sniff the system libs, a big no-no.  We skip a
	# couple that will never be detected (e.g. DirectX)
	_static_configure HAVE_OPENSSL	 1
	_static_configure HAVE_JPEG	 1
	_static_configure HAVE_PNG	 1
	_static_configure HAVE_TIFF	 1
	_static_configure HAVE_TAR	 1
	_static_configure HAVE_FFTW
	_static_configure HAVE_SQUISH
	_static_configure HAVE_BDB
	_static_configure HAVE_CG
	_static_configure HAVE_CGGL
	_static_configure HAVE_VRPN
	_static_configure HAVE_HELIX
	_static_configure HAVE_ZLIB	 1
	_static_configure HAVE_GL	 1
	_static_configure HAVE_MESA	 1
	_static_configure HAVE_GLES
	_static_configure HAVE_GLES2
	_static_configure HAVE_EGL
	_static_configure HAVE_SDL
	_static_configure HAVE_X11	 1
	_static_configure HAVE_XF86DGA
	_static_configure HAVE_XRANDR	 1
	_static_configure HAVE_XCURSOR	 1
	_static_configure HAVE_OPENCV
	_static_configure HAVE_FFMPEG
	_static_configure HAVE_ODE
	_static_configure HAVE_AWESOMIUM
	_static_configure HAVE_RAD_MSS
	_static_configure HAVE_FMODEX
	_static_configure HAVE_OPENAL	 1
	_static_configure HAVE_PHYSX
	_static_configure HAVE_FREETYPE  1
	_static_configure HAVE_WX
	_static_configure HAVE_FLTK
	_static_configure HAVE_FCOLLADA
	_static_configure HAVE_COLLAA14DOM
	_static_configure HAVE_COLLAA15DOM
	_static_configure HAVE_ASSIMP
	_static_configure HAVE_ARTOOLKIT
	_static_configure HAVE_ROCKET	 1
	_static_configure HAVE_BULLET
	_static_configure HAVE_VORBIS	 1

	# A couple of generic features
	_static_configure HAVE_NET	 1
	_static_configure HAVE_AUDIO	 1

	popd

	PPREMAKE_CONFIG=${S}/../Config.pp ppremake
}

src_compile() {
	PPREMAKE_CONFIG=${S}/../Config.pp emake
}

src_install() {
	PPREMAKE_CONFIG=${S}/../Config.pp emake DESTDIR=${D} install || die "Install failed"

	# Install Config.pp for use by dependent builds
	insinto /usr/share/panda3d/ppremake
	doins ../Config.pp

	# Install our patches since panda3d-core (and
	# possibly others) will need to re-apply them.
	insinto /usr/share/panda3d/dtool/patch
	doins "${FILESDIR}/${P}-honor-destdir.patch"
	doins "${FILESDIR}/${P}-dedicated-headers-dir.patch"
	doins "${FILESDIR}/${P}-etc-subdir.patch"
	doins "${FILESDIR}/${P}-test-install-dirs.patch"
}
