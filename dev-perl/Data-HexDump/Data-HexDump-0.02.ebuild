# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-Hostname-Long/Sys-Hostname-Long-1.400.0.ebuild,v 1.2 2011/09/03 21:05:14 tove Exp $

EAPI=5

MODULE_AUTHOR=FTASSIN
MODULE_VERSION=0.02
inherit perl-module

DESCRIPTION="Hexadecial Dumper"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

#/usr/bin/hexdump collides with binary from util-linux
src_install() {
	perl-module_src_install
	echo "Renaming /usr/bin/hexdump to /usr/bin/hexdump.pl to prevent file collisions."
	mv ${D}/usr/bin/hexdump ${D}/usr/bin/hexdump.pl
}

