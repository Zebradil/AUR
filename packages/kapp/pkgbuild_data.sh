# shellcheck shell=bash disable=SC2034,SC2154

header='# Maintainer: George Tsiamasiotis <gtsiam@windowslive.com>
# Maintainer: German Lashevich <german.lashevich@gmail.com>
# Contributor: David Birks <david@birks.dev>
#
# Source: https://github.com/zebradil/aur
#
# shellcheck disable=SC2034,SC2154'

pkgname=kapp
_github_repo="carvel-dev/$pkgname"

_gh_info=$(pkgb:get_github_info "$_github_repo")
if [[ -n "$_gh_info" ]]; then
    eval "$_gh_info"
    pkgver="${pkgver#v}"
    url="${url:-$_github_repo_url}"
else
    log::error "Failed to get info from GitHub"
fi

provides=("${pkgname}")
makedepends=(bash go)
source=("${pkgname}-${pkgver}::https://github.com/$_github_repo/archive/v${pkgver}.tar.gz")
sha256sums=('')
_z_update_hashsums=true

build() {
    set -eo pipefail

    cd "$pkgname-$pkgver"

    export CGO_CPPFLAGS="${CPPFLAGS}"
    export CGO_CFLAGS="${CFLAGS}"
    export CGO_CXXFLAGS="${CXXFLAGS}"
    export CGO_LDFLAGS="${LDFLAGS}"
    export GOFLAGS="-buildmode=pie -trimpath -ldflags=-linkmode=external -mod=readonly -modcacherw"
    # make sure CGO is enabled to allow external linking
    sed -i "s/CGO_ENABLED=0/CGO_ENABLED=1/" hack/build.sh
    hack/build.sh "$pkgver"
}

package() {
    set -eo pipefail

    cd "$pkgname-$pkgver"

    BIN=$pkgname

    install -Dm755 $BIN -t "$pkgdir/usr/bin"

    # completions
    mkdir -p "$pkgdir/usr/share/bash-completion/completions/"
    mkdir -p "$pkgdir/usr/share/zsh/site-functions/"
    mkdir -p "$pkgdir/usr/share/fish/vendor_completions.d/"
    ./$BIN completion bash | install -Dm644 /dev/stdin "$pkgdir/usr/share/bash-completion/completions/$BIN"
    ./$BIN completion fish | install -Dm644 /dev/stdin "$pkgdir/usr/share/fish/vendor_completions.d/$BIN.fish"
    ./$BIN completion zsh | install -Dm644 /dev/stdin "$pkgdir/usr/share/zsh/site-functions/_$BIN"
}
