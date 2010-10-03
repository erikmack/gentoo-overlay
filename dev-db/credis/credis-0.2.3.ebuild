# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="C client library for Redis"
HOMEPAGE="http://code.google.com/p/credis/"
SRC_URI="http://credis.googlecode.com/files/credis-0.2.3.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} dev-db/redis"

src_test() {
	# tests fail if redis server isn't running
	# we want the build to succeed in that case
	pgrep redis || return
	${S}/credis-test || die "Redis is running, but tests failed"
}

src_install() {
	dolib.so libcredis.so || die "Couldn't install libcredis.so"
	dodoc README || die
}
