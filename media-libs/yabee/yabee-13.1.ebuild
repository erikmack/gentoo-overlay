# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Yet Another Blender EGG Exporter"
HOMEPAGE="https://code.google.com/p/yabee"
SRC_URI="https://yabee.googlecode.com/files/YABEE_r13_1_b266.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# This only matters so that we know exactly what Blender subdir to
# install into.
BLENDER_VERSION="2.69"

DEPEND="=media-gfx/blender-${BLENDER_VERSION}"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_install() {
    local target=${D}/usr/share/blender/${BLENDER_VERSION}/scripts/addons
    install -d $target
    cd $target || die
    cp --recursive ${S}/* . || die

    einfo "Remember that the plugin must be enabled in the"
    einfo "Blender interface.  This is a user-level action,"
    einfo "so portage can't automate it"
}
