# shellcheck shell=bash disable=SC2034,SC2154

pkgname=cloudflare-dynamic-dns
_repo="zebradil/$pkgname"
provides=("${pkgname}")
pkgver="$(pkgb:get_latest_github_release "$_repo")"
pkgdesc='Updates AAAA records at Cloudflare according to the current IPv6 address'
url="https://github.com/$_repo"
license=('MIT')
makedepends=('go')
source=("${pkgname}-${pkgver}::https://github.com/$_repo/archive/${pkgver}.tar.gz")
sha256sums=('')
_z_update_hashsums=true

prepare() {
  cd "$pkgname-$pkgver" || exit 1
  mkdir -p build/
}

build() {
  cd "$pkgname-$pkgver" || exit 1
  export CGO_ENABLED=0
  GOFLAGS="\
    -buildmode=pie \
    -trimpath \
    -ldflags=-linkmode=external \
    -ldflags=-X=main.version=$pkgver \
    -ldflags=-X=main.commit=$pkgver \
    -ldflags=-X=main.date=$(date -Iseconds) \
    -mod=readonly \
    -modcacherw"
  export GOFLAGS
  go build -o build/$pkgname main.go
}

check() {
  cd "$pkgname-$pkgver" || exit 1
  go test ./...
}

package() {
  set -eo pipefail

  cd "$pkgname-$pkgver"

  BIN="build/$pkgname"

  install -Dm755 "$BIN" -t "$pkgdir/usr/bin"
  install -Dm644 systemd/* -t "$pkgdir/usr/lib/systemd/system"
  install -m700 -d "$pkgdir/etc/$pkgname/config.d"
}
