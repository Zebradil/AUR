# shellcheck disable=SC2034,SC2154

pkgname=python-powerline-taskwarrior
_name=${pkgname#python-}
pkgver=2.0.0
pkgdesc="Powerline segment for showing information from Taskwarrior task manager"
license=(MIT)
url="https://github.com/Zebradil/powerline-taskwarrior"
depends=(python3 powerline)
makedepends=(python-build python-installer python-wheel)
source=("https://files.pythonhosted.org/packages/source/${_name::1}/$_name/$_name-$pkgver.tar.gz")
sha256sums=('SKIP')
_z_update_hashsums=true

build() {
    cd "${pkgname#python-}-$pkgver" || exit 1
    python -m build --wheel --no-isolation
}

package() {
    cd "${pkgname#python-}-$pkgver" || exit 1
    python -m installer --destdir="$pkgdir" dist/*.whl
}
