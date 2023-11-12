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
pkgver="${pkgver//_/-}"

pkgrel=1
pkgdesc='Program that allows to query and change the XKB layout state (with i3wm auto-switch mode)'
conflicts=('xkb-switch' 'xkb-switch-i3')
provides=('xkb-switch')
arch=('i686' 'x86_64')
url="https://github.com/$_repo"
license=('MIT')
depends=('libx11' 'libxkbfile' 'i3-wm' 'libsigc++' 'jsoncpp')
makedepends=('git' 'cmake')
source=(
    "git+https://github.com/$_repo.git#branch=master"
    "git+https://github.com/drmgc/i3ipcpp.git"
)
sha1sums=(
    'SKIP'
    'SKIP'
)

pkgver() {
    cd "${pkgname%-git}"
    git describe --long --tags | sed 's/\([^-]*-g\)/r\1/;s/-/./g'
}

build() {
    cd "${srcdir}/${pkgname%-git}"
    git submodule init
    git config "submodule.i3ipc++.url" "${srcdir}/i3ipcpp"
    git submodule update

    cmake -DCMAKE_INSTALL_PREFIX=/usr .
    make
}

package() {
    cd "${srcdir}/${pkgname%-git}"
    make DESTDIR="$pkgdir/" install
}
