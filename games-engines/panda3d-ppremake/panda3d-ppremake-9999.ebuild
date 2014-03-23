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

inherit cvs autotools

ECVS_AUTH="pserver"
ECVS_USER="anonymous"
ECVS_SERVER="panda3d.cvs.sourceforge.net:/cvsroot/panda3d"
ECVS_MODULE="panda3d"
ECVS_PASS=""

S="${WORKDIR}/panda3d/ppremake"

src_prepare() {

	# Panda's dependency cache build feature violates the portage sandbox
	epatch "${FILESDIR}/${P}-disable-dependency-cache.patch"

	eautoreconf
}
