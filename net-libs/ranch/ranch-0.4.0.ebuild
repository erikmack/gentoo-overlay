EAPI=5

inherit git-2

SLOT="0"
LICENSE="ISC"
DESCRIPTION="Socket acceptor pool for TCP protocols"
HOMEPAGE="https://github.com/extend/ranch"
KEYWORDS="~amd64"

RDEPEND="dev-lang/erlang"
DEPEND="${RDEPEND}
        dev-util/rebar"

EGIT_REPO_URI="https://github.com/extend/ranch.git"
EGIT_COMMIT="0.4.0"

src_compile() {
    rebar compile
    rebar doc
}

src_install() {
    dodir /usr/lib/erlang/lib/${PF}/ebin
    insinto /usr/lib/erlang/lib/${PF}/ebin
    doins ebin/*
    
    dodir /usr/lib/erlang/lib/${PF}/src
    insinto /usr/lib/erlang/lib/${PF}/src
    doins src/*
    
    dohtml doc/*
}


