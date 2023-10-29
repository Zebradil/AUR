# shellcheck disable=SC2034,SC2154

pkgname=docoseco
pkgver=1.0.0
pkgdesc="Automatize management of docker confgs and secrets"
license=(MIT)
url="https://github.com/Zebradil/docoseco"
depends=(python3 python-ruamel-yaml)
makedepends=(python-build python-installer python-wheel)
provides=(docoseco)
source=(https://files.pythonhosted.org/packages/source/${pkgname::1}/$pkgname/$pkgname-$pkgver.tar.gz)
sha512sums=('30c7652873e296237bc0eda6226a581f7ad618f473790cb843de041afd324c37255ed88acd97783c5f1533dd4ca7c3974f0f3d87c42c2849426fe15ed5803199')

build() {
    cd "$pkgname-$pkgver" || exit 1
    python -m build --wheel --no-isolation
}

package() {
    cd "$pkgname-$pkgver" || exit 1
    python -m installer --destdir="$pkgdir" dist/*.whl
}
