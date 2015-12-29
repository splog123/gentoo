# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-Hostname-Long/Sys-Hostname-Long-1.400.0.ebuild,v 1.2 2011/09/03 21:05:14 tove Exp $

EAPI=5

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=1.1102
inherit perl-module

DESCRIPTION="Capture STDOUT and STDERR from Perl code"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="
	dev-perl/Module-Build
"
