# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=(python2_7)

inherit eutils user git-2 python-single-r1

EGIT_REPO_URI="https://github.com/RuudBurger/CouchPotatoServer.git"

DESCRIPTION="CouchPotatoServer (CPS) V2 is an automatic NZB and torrent downloader for movies"
HOMEPAGE="https://github.com/RuudBurger/CouchPotatoServer#readme"

LICENSE="GPL-2" # only
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

pkg_setup() {
	python_single-r1_pkg_setup

	# Create download group
	enewgroup download 
	# Create download user, put in download group
	enewuser download -1 -1 -1 download
}

src_install() {
	dodoc README.md

	newconfd "${FILESDIR}/${PN}.conf" ${PN}
	newinitd "${FILESDIR}/${PN}.init" ${PN}

	# Location of data files
	keepdir /var/${PN}
	fowners -R download:download /var/${PN}

	insinto /etc/${PN}
	insopts -m0660 -o download -g download
	doins "${FILESDIR}/${PN}.ini"

	# Rotation of log files
	insinto /etc/logrotate.d
	insopts -m0644 -o root -g root
	newins "${FILESDIR}/${PN}.logrotate" ${PN}

	insinto /usr/share/${PN}
	doins -r couchpotato libs CouchPotato.py version.py
}

pkg_postinst() {

	# we need to remove .git which old ebuild installed
	if [[ -d "/usr/share/${PN}/.git" ]] ; then
	   ewarn "stale files from previous ebuild detected"
	   ewarn "/usr/share/${PN}/.git removed."
	   ewarn "To ensure proper operation, you should unmerge package and remove directory /usr/share/${PN} and then emerge package again"
	   ewarn "Sorry for the inconvenience"
	   rm -Rf "/usr/share/${PN}/.git"
	fi

	elog "Couchpotato has been installed with data directories in /var/${PN}"
	elog
	elog "New user/group download:download has been created"
	elog
	elog "Config file is located in /etc/${PN}/${PN}.ini"
	elog "Note: Log files are located in /var/${PN}/logs"
	elog
	elog "Please configure /etc/conf.d/${PN} before starting as daemon!"
	elog
	elog "Start with ${ROOT}etc/init.d/${PN} start"
	elog "Visit http://<host ip>:5050 to configure Couchpotato"
	elog "Default web username/password : download/secret"
	elog
}

