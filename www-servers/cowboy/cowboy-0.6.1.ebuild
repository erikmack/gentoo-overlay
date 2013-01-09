EAPI=5

inherit git-2

SLOT="0"
LICENSE="ISC"
DESCRIPTION="Small, fast, modular HTTP server written in Erlang"
HOMEPAGE="https://github.com/extend/cowboy"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND="dev-lang/erlang"
DEPEND="${RDEPEND}
        dev-util/rebar"

EGIT_REPO_URI="https://github.com/extend/cowboy.git"
EGIT_COMMIT="0.6.1"

src_compile() {
    rebar compile

    if use doc; then
	rebar doc
    fi
}

src_install() {
    dodir /usr/lib/erlang/lib/${PF}/ebin
    insinto /usr/lib/erlang/lib/${PF}/ebin
    doins ebin/*
    
    dodir /usr/lib/erlang/lib/${PF}/src
    insinto /usr/lib/erlang/lib/${PF}/src
    doins src/*
    
    if use doc; then
	dohtml doc/*
    fi
}
