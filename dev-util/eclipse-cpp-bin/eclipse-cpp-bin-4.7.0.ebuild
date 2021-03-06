# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils versionator

RNAME="oxygen"
SR="R"

DESCRIPTION="Eclipse IDE for C/C++"
HOMEPAGE="http://www.eclipse.org"

SRC_BASE="http://eclipse.bluemix.net/packages/${RNAME}/data/eclipse-cpp-${RNAME}-${SR}-linux-gtk"
SRC_URI="
	amd64? ( ${SRC_BASE}-x86_64.tar.gz -> ${P}-x86_64.tar.gz )
	x86? ( ${SRC_BASE}.tar.gz -> ${P}.tar.gz )
"

LICENSE="EPL-1.0"
SLOT="4.7"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND="
	>=virtual/jdk-1.8
	x11-libs/gtk+:2
"

S=${WORKDIR}/eclipse

src_install() {
	local dest=/opt/${PN}-${SLOT}

	insinto ${dest}
	doins -r features icon.xpm plugins artifacts.xml p2 eclipse.ini configuration dropins

	exeinto ${dest}
	doexe eclipse

	dohtml -r readme/*

	cp "${FILESDIR}"/eclipserc-bin "${T}/eclipserc-bin-${SLOT}" || die
	cp "${FILESDIR}"/eclipse-bin "${T}/eclipse-bin-${SLOT}" || die
	sed "s@%SLOT%@${SLOT}@" -i "${T}"/eclipse{,rc}-bin-${SLOT} || die

	insinto /etc
	newins "${T}"/eclipserc-bin-${SLOT} eclipserc-bin-${SLOT}

	newbin "${T}"/eclipse-bin-${SLOT} eclipse-cpp-${SLOT}
	make_desktop_entry "eclipse-cpp-${SLOT}" "Eclipse ${PV}" "${dest}/icon.xpm" "Development;IDE"

}
