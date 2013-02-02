EAPI="2"

# TODO: needed?
inherit eutils

IUSE="doc"
DESCRIPTION="Extincter is an arcade game for HTML5 canvas, Websockets, and Erlang"
SRC_URI="http://cca5776e216269181119-b6f23c0a32ff8f4a34aaf282fcfbc8f5.r53.cf2.rackcdn.com/extincter-cab5a0.tar.gz"

HOMEPAGE="http://mackdanz.net"
SLOT="0"
LICENSE="AGPL-3"
KEYWORDS="~amd64"

DEPEND="dev-lang/erlang
        doc? ( media-gfx/graphviz[svg] )"
RDEPEND="${DEPEND} =net-libs/ranch-0.4.0
	>=www-servers/cowboy-0.6.1"

src_compile() {
    rebar compile

    if use doc; then
	pushd doc
	./builddot.sh
	popd
    fi

}

src_install() {
    dodir /usr/lib/erlang/lib/${PF}/ebin
    insinto /usr/lib/erlang/lib/${PF}/ebin
    doins ebin/*
    
    dodir /usr/lib/erlang/lib/${PF}/src
    insinto /usr/lib/erlang/lib/${PF}/src
    doins src/*

    dodir /usr/lib/erlang/lib/${PF}/priv/www
    insinto /usr/lib/erlang/lib/${PF}/priv/www
    doins priv/www/*

    dodir /usr/lib/erlang/lib/${PF}/priv/www/assets
    insinto /usr/lib/erlang/lib/${PF}/priv/www/assets
    doins priv/www/assets/*

    dodir /usr/lib/erlang/lib/${PF}/priv/www/script
    insinto /usr/lib/erlang/lib/${PF}/priv/www/script
    doins priv/www/script/*

    dodir /usr/lib/erlang/lib/${PF}/priv/www
    insinto /usr/lib/erlang/lib/${PF}/priv/www
    doins priv/www/*

    if use doc; then
	dodir /usr/lib/erlang/lib/${PF}/doc
	insinto /usr/lib/erlang/lib/${PF}/doc
	doins doc/*
    fi

    insinto /usr/lib/erlang/lib/${PF}
    doins *
}
