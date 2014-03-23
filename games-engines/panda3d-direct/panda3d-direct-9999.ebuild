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
RDEPEND="${DEPEND}
games-engines/panda3d-core
"

inherit cvs

ECVS_AUTH="pserver"
ECVS_USER="anonymous"
ECVS_SERVER="panda3d.cvs.sourceforge.net:/cvsroot/panda3d"
ECVS_MODULE="panda3d"
ECVS_PASS=""
#ECVS_CVS_OPTIONS="-z3"

S="${WORKDIR}/panda3d/direct"

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

	epatch "${FILESDIR}/${P}-exclude-bad-calls.patch"

}

src_configure() {
	PPREMAKE_CONFIG=/usr/share/panda3d/ppremake/Config.pp ppremake
}

src_compile() {
	PPREMAKE_CONFIG=/usr/share/panda3d/ppremake/Config.pp emake
}

src_install() {
	PPREMAKE_CONFIG=/usr/share/panda3d/ppremake/Config.pp emake DESTDIR=${D} install
}
