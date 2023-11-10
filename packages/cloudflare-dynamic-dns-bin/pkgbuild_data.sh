# shellcheck disable=SC2034,SC2154

_name=cloudflare-dynamic-dns
pkgname="${_name}-bin"
pkgver="$(pkgb:get_latest_github_release "$_name")"
provides=("${_name}")
conflicts=("${_name}")
pkgdesc='Updates AAAA records at Cloudflare according to the current IPv6 address'
url='https://github.com/Zebradil/cloudflare-dynamic-dns'
license=('MIT')
makedepends=('go')
arch=('x86_64' 'aarch64')
source_x86_64=("${pkgname}-${pkgver}::https://github.com/zebradil/${_name}/releases/download/${pkgver}/${_name}_linux_amd64.tar.gz")
sha256sums_x86_64=('SKIP')
source_aarch64=("${pkgname}-${pkgver}::https://github.com/zebradil/${_name}/releases/download/${pkgver}/${_name}_linux_arm64.tar.gz")
sha256sums_aarch64=('SKIP')
update_hashsums=true

package() {
    _name=${pkgname%-bin}
    BIN=$_name

    install -Dm755 $BIN -t "$pkgdir/usr/bin"
    install -Dm644 systemd/* -t "$pkgdir/usr/lib/systemd/system"
    install -m700 -d "$pkgdir/etc/$_name/config.d"

    # completions
    mkdir -p "$pkgdir/usr/share/bash-completion/completions/"
    mkdir -p "$pkgdir/usr/share/zsh/site-functions/"
    mkdir -p "$pkgdir/usr/share/fish/vendor_completions.d/"
    ./$BIN completion bash | install -Dm644 /dev/stdin "$pkgdir/usr/share/bash-completion/completions/$BIN"
    ./$BIN completion fish | install -Dm644 /dev/stdin "$pkgdir/usr/share/fish/vendor_completions.d/$BIN.fish"
    ./$BIN completion zsh  | install -Dm644 /dev/stdin "$pkgdir/usr/share/zsh/site-functions/_$BIN"
}
