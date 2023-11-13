# shellcheck disable=SC2034,SC2154

contributors=(
    'Orestis Floros <orestisf1993@gmail.com>'
    'Doron Behar <doron.behar@gmail.com>'
)

_i3ipcpp_ver=1bf594d1f25e63122c6f92c2a61a848b45457e08

pkgname=xkb-switch-i3
pkgver=2.0.1+i3_5
pkgrel=1
pkgdesc='Program that allows to query and change the XKB layout state (with i3wm auto-switch mode)'
conflicts=('xkb-switch')
provides=('xkb-switch')
arch=('i686' 'x86_64')
url='https://github.com/zebradil/xkb-switch-i3'
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
    "${pkgname}-${pkgver}.tar.gz::https://github.com/zebradil/${pkgname}/archive/${pkgver//_/-}.tar.gz"
    "i3ipcpp-${_i3ipcpp_ver}.tar.gz::https://api.github.com/repos/drmgc/i3ipcpp/tarball/${_i3ipcpp_ver}"
)
# Old approach, reactivate when a new version of i3ipcpp is released
# "i3ipcpp-${_i3ipcpp_ver}.tar.gz::https://github.com/drmgc/i3ipcpp/archive/v${_i3ipcpp_ver}.tar.gz"
sha256sums=(
    'SKIP'
    'SKIP'
)
_z_update_hashsums=true

build() {
    cd "${srcdir}/${pkgname}-${pkgver//[_+]/-}"
    # Old approach, reactivate when a new version of i3ipcpp is released
    # mv -T "${srcdir}/i3ipcpp-${_i3ipcpp_ver}" ./i3ipc++
    mv -T "${srcdir}"/drmgc-i3ipcpp-* ./i3ipc++
    cmake -DCMAKE_INSTALL_PREFIX=/usr .
    make
}

package() {
    cd "${srcdir}/${pkgname}-${pkgver//[_+]/-}"
    make DESTDIR="$pkgdir/" install
}
