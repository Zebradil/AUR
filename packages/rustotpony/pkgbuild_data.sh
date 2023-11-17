# shellcheck disable=SC2034,SC2154

pkgname=rustotpony
_repo="zebradil/$pkgname"
provides=(totp)
pkgver="$(pkgb:get_latest_github_release "$_repo")"
pkgdesc='RusTOTPony — CLI manager of one-time password generators like Google Authenticator'
pkgrel=2
conflicts=('rustotpony-bin')
arch=('i686' 'x86_64' 'armv6h' 'armv7h')
url="https://github.com/$_repo"
license=('MIT')
depends=('gcc-libs' 'glibc')
makedepends=('cargo')
source=("${pkgname}-${pkgver}::https://github.com/$_repo/archive/${pkgver}.tar.gz")
sha256sums=('')
_z_update_hashsums=true

build() {
    set -eo pipefail
    cd "${pkgname}-${pkgver}"
    cargo build --release
}

package() {
    set -eo pipefail
    _binname=totp
    install -Dm755 "${srcdir}/${pkgname}-${pkgver}/target/release/${_binname}" "${pkgdir}/usr/bin/${_binname}"
}
