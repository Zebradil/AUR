# shellcheck shell=bash disable=SC2034,SC2154

pkgname=rustotpony-bin
_repo="zebradil/${pkgname%-bin}"
_binname=totp
provides=($_binname)
pkgver="$(pkgb:get_latest_github_release "$_repo")"
pkgdesc='RusTOTPony — CLI manager of one-time password generators like Google Authenticator'
pkgrel=2
conflicts=('rustotpony')
arch=('x86_64')
url="https://github.com/$_repo"
license=('MIT')
source=("${pkgname}-${pkgver}::https://github.com/$_repo/releases/download/${pkgver}/$_binname-linux")
sha256sums=('')
_z_update_hashsums=true

package() {
    set -eo pipefail
    _binname=totp
    install -Dm755 "${srcdir}/${pkgname}-${pkgver}" "${pkgdir}/usr/bin/${_binname}"
}
