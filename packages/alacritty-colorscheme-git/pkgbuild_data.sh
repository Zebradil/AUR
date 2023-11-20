# shellcheck shell=bash disable=SC2034,SC2154

_z_pkgname=alacritty-colorscheme
pkgname="$_z_pkgname-git"
pkgver=r51.257e466
pkgdesc='Change colorscheme of alacritty with ease'
arch=(any)
url="https://github.com/zebradil/$_z_pkgname/"
license=(Apache)
depends=(
    python-ruamel-yaml
    python-typed-argument-parser
    python-pynvim
)
makedepends=(
    python-build
    python-installer
    python-poetry-core
    python-wheel
)
provides=("$_z_pkgname")
conflicts=("$_z_pkgname")
source=("git+https://github.com/zebradil/$_z_pkgname.git")
sha256sums=('SKIP')

_z_aur_deps=(python-typed-argument-parser)

pkgver() {
    (
        set -eo pipefail
        cd "${_z_pkgname}"
        git describe --long 2>/dev/null \
            | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-/./g' \
            || printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
    )
}

build() {
    (
        set -eo pipefail
        cd "${_z_pkgname}"
        python -m build --wheel
    )
}

package() {
    (
        set -eo pipefail
        cd "${_z_pkgname}"
        python -m installer --destdir="$pkgdir" dist/*.whl
    )
}
