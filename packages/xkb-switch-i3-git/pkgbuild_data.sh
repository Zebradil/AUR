# shellcheck disable=SC2034,SC2154

contributors=(
    'Orestis Floros <orestisf1993@gmail.com>'
    'Doron Behar <doron.behar@gmail.com>'
)

_pkgname=xkb-switch-i3
_repo="zebradil/$_pkgname"
_default_version=2.0.1+i3_5

pkgname="$_pkgname-git"

pkgver="$(pkgb:get_latest_github_tag "$_repo")"
pkgver="${pkgver:-$_default_version}"
pkgver="${pkgver//-/_}"

pkgrel=1
pkgdesc='Program that allows to query and change the XKB layout state (with i3wm auto-switch mode)'
conflicts=('xkb-switch' 'xkb-switch-i3')
provides=('xkb-switch')
arch=('i686' 'x86_64')
url="https://github.com/$_repo"
license=('MIT')
depends=(
    'i3-wm'
    'jsoncpp'
    'libsigc++'
    'libx11'
    'libxkbfile'
)
makedepends=(
    'cmake'
    'git'
    'i3-wm'
    'libsigc++'
    'libx11'
    'libxkbfile'
)
source=(
    "git+https://github.com/$_repo.git#branch=master"
    "git+https://github.com/drmgc/i3ipcpp.git"
)
sha256sums=(
    'SKIP'
    'SKIP'
)

pkgver() {
    cd "${pkgname%-git}"
    git describe --long --tags | sed 's/\([^-]*-g\)/r\1/;s/-/_/g'
}

build() {
    cd "${srcdir}/${pkgname%-git}"
    git submodule init
    git config "submodule.i3ipc++.url" "${srcdir}/i3ipcpp"
    # From git 2.38.1-1, "git submodule" in PKGBUILD does not work
    # unless we change the git config "protocol.file.allow" [1,2].
    # [1] https://bugs.archlinux.org/task/76255
    # [2] https://bbs.archlinux.org/viewtopic.php?pid=2063104#p2063104
    git -c protocol.file.allow=always submodule update

    cmake -DCMAKE_INSTALL_PREFIX=/usr .
    make
}

package() {
    cd "${srcdir}/${pkgname%-git}"
    make DESTDIR="$pkgdir/" install
}
