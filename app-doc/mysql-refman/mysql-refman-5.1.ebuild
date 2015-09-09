# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Official MySQL reference manual"
HOMEPAGE="http://dev.mysql.com/doc/"
SRC_URI="http://downloads.mysql.com/docs/refman-5.1-en.html-chapter.tar.gz"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT="strip binchecks"

S=${WORKDIR}/refman-5.0-en.html-chapter

src_install() {
	insinto /usr/share/doc/${P}
	doins -r * || die
}

