# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils qt4-r2 cmake-utils git-2

DESCRIPTION="plaYUVer is an open-source QT based raw video player"
HOMEPAGE="https://github.com/pixlra/playuver"

EGIT_REPO_URI="https://github.com/pixlra/playuver.git"
EGIT_MASTER="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-debug kde qt5 -qt4 -ffmpeg -opencv install_libs"

DEPEND="
  qt5? (
    dev-qt/qtcore:5
    dev-qt/qtgui:5
    dev-qt/qtwidgets:5
  )
  qt4? (
    dev-qt/qtcore:4
    dev-qt/qtgui:4
  )
  ffmpeg? ( media-video/ffmpeg )
  opencv? ( qt5? ( media-libs/opencv[-qt4] ) !qt5? (  media-libs/opencv ) )
"
  
RDEPEND="${DEPEND}"

REQUIRED_USE="
  ?? ( qt5 qt4 )
"


S="${WORKDIR}/${PN}"

src_unpack() {
	git-2_src_unpack
}

src_configure() {
  local mycmakeargs=(
    $(cmake-utils_use_use qt4) # use qt5
    $(cmake-utils_use_use ffmpeg) # support ffmpeg
    $(cmake-utils_use_use opencv) # support opencv
  )
  if use debug; then
    mycmakeargs+=( -DCMAKE_BUILD_TYPE=Debug )
  fi
  if use install_libs; then
    mycmakeargs+=( -DPLAYUVER_INSTALL_LIBS=ON )
  else
    mycmakeargs+=( -DPLAYUVER_INSTALL_LIBS=OFF )
  fi
  cmake-utils_src_configure
}