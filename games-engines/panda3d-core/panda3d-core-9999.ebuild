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

# TODO: consider sub-slot := for ppremake since 
# a ppremake rebuild should trigger rebuilds of
# dependent packages
DEPEND="games-engines/panda3d-ppremake
games-engines/panda3d-build
"

inherit cvs

ECVS_AUTH="pserver"
ECVS_USER="anonymous"
ECVS_SERVER="panda3d.cvs.sourceforge.net:/cvsroot/panda3d"
ECVS_MODULE="panda3d"
ECVS_PASS=""
#ECVS_CVS_OPTIONS="-z3"

S="${WORKDIR}/panda3d/panda"

src_prepare() {

	pushd ../dtool
	# You may recognize these patches from the panda3d-build ebuild :-(
	# While the docs say to 'make install' from the dtool directory,
	# the Makefiles for this 'panda' dir expect to use all the sources
	# in ../dtool ... so we patch them again.  What a mess.
	for patch in /usr/share/panda3d/dtool/patch/*.patch; do
		epatch ${patch}
	done
	popd
}

src_configure() {
	PPREMAKE_CONFIG=/usr/share/panda3d/ppremake/Config.pp ppremake
}

src_compile() {
	PPREMAKE_CONFIG=/usr/share/panda3d/ppremake/Config.pp emake
}

src_install() {
	PPREMAKE_CONFIG=/usr/share/panda3d/ppremake/Config.pp emake DESTDIR=${D} install || die "Install failed"

	einfo "Writing override .prc"
	# Override some canned defaults so that basic 'pview foo.egg' commands work
	echo "plugin-path /usr/lib" >${D}/etc/panda3d/30_gentoo.prc
	echo "load-display p3glxdisplay" >>${D}/etc/panda3d/30_gentoo.prc
	echo "# load-display p3tinydisplay" >>${D}/etc/panda3d/30_gentoo.prc

	einfo "Installing sample models"
	dodir /usr/share/panda3d/models
	cp --recursive ../models "${D}/usr/share/panda3d"
	find "${D}/usr/share/panda3d/models" -type d -name CVS -exec rm -rf '{}' ';'
}
