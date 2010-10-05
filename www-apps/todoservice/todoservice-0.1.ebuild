# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="A not-quite-RESTful todo API implemented as C CGI with Redis backend"
HOMEPAGE="http://github.com/erikmack/todoservice"
SRC_URI="http://github.com/downloads/erikmack/todoservice/todoservice-0.1.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

# TODO, maybe: curl & libxslt are only used by client, so add a "client" use
# flag
DEPEND="dev-db/credis"
RDEPEND="${DEPEND} virtual/httpd-cgi dev-db/redis dev-libs/libxslt net-misc/curl"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS README ChangeLog TODO AUTHORS || die
}
