# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Shamelessly ripped from the "raw" overlay

EAPI="5"

inherit eutils

DESCRIPTION="UniFi controller"
HOMEPAGE="https://www.ubnt.com/download/unifi"

SRC_URI="http://dl.ubnt.com/unifi/"${PV%_*}"/unifi_sysvinit_all.deb -> ${PN}-${PV}.deb"

SLOT="0"
KEYWORDS="~amd64 ~arm"

DEPEND=""
RDEPEND="${DEPEND}
	dev-db/mongodb
	sys-libs/libcap
	|| (
		dev-java/icedtea:8[sunec]
		dev-java/icedtea-bin:8
	)"

S=${WORKDIR}

src_unpack() {
	default_src_unpack
	cd "${WORKDIR}" || die
	unpacker data.tar.xz && mv usr/lib/unifi "${S}" || die
}

src_prepare() {
	local n="$S/lib/native"
	if use amd64; then
		rm "$n/Linux/armhf" -Rf
	else
		rm "$n/Linux/x86_64" -Rf
	fi
	rm "$n/"{Mac,Windows} -Rf
}

src_install() {
	dodir /opt
	mv "${S}" "${D}"/opt/UniFi || die
	rm "${D}"/opt/UniFi/bin/mongod
	exeinto /etc/unifi/bin
	doexe "${FILESDIR}"/mongod.sh
	dosym /etc/unifi/bin/mongod.sh /opt/UniFi/bin/mongod
	newinitd "${FILESDIR}/${PN}".init "${PN}"
}

pkg_postinst() {
	einfo 'Remember to use NSS-enabled java VM (dev-java/icedtea:8[sunec] is good),'
	einfo 'then uncomment NSS security provider in ${java.home}/jre/lib/security/java.security:'
	einfo 'security.provider.10=sun.security.pkcs11.SunPKCS11 ${java.home}/lib/security/nss.cfg'
}

