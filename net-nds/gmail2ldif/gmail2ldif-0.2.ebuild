# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Convert a contact list downloaded from GMail into an LDIF script (for import to an LDAP directory)"
HOMEPAGE="http://github.com/erikmack/gmail2ldif"
SRC_URI="http://github.com/downloads/erikmack/gmail2ldif/gmail2ldif-0.2.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/libiconv"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS README ChangeLog TODO AUTHORS || die
}
