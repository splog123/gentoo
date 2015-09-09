# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:
# /var/cvsroot/gentoo-x86/dev-perl/Sys-Hostname-Long/Sys-Hostname-Long-1.400.0.ebuild,v
# 1.2 2011/09/03 21:05:14 tove Exp $

EAPI=5

MODULE_AUTHOR=MANOWAR
MODULE_VERSION=0.20
inherit perl-module

DESCRIPTION="Authen::Radius - provide simple Radius client facilities"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="dev-lang/perl"

MY_P=RadiusPerl-${PV}
SRC_URI="mirror://cpan/authors/id/M/MA/MANOWAR/${MY_P}.tar.gz"

#Tests are interactive and need a live Radius server
src_test(){
	ewarn "Interactive tests skipped"
}

src_install() {
	mkdir -p ${D}/etc/raddb
	sed -i -e "s:my \$raddb_dir = '/etc/raddb';:my \$raddb_dir = '${D}/etc/raddb';:" install-radius-db.PL 
	perl-module_src_install
}

