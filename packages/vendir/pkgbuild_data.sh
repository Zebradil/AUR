# shellcheck shell=bash disable=SC2034,SC2154

pkgname=vendir
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
    cd "$pkgname-$pkgver" || exit 1
    export CGO_CPPFLAGS="${CPPFLAGS}"
    export CGO_CFLAGS="${CFLAGS}"
    export CGO_CXXFLAGS="${CXXFLAGS}"
    export CGO_LDFLAGS="${LDFLAGS}"
    export GOFLAGS="-buildmode=pie -trimpath -ldflags=-linkmode=external -mod=readonly -modcacherw"

    ./hack/build.sh "$pkgver"
}

package() {
    cd "$pkgname-$pkgver" || exit 1

    BIN=$pkgname

    install -Dm755 $BIN -t "$pkgdir/usr/bin"

    # completions
    mkdir -p "$pkgdir/usr/share/bash-completion/completions/"
    mkdir -p "$pkgdir/usr/share/zsh/site-functions/"
    mkdir -p "$pkgdir/usr/share/fish/vendor_completions.d/"
    ./$BIN completion bash | install -Dm644 /dev/stdin "$pkgdir/usr/share/bash-completion/completions/$BIN"
    ./$BIN completion fish | install -Dm644 /dev/stdin "$pkgdir/usr/share/fish/vendor_completions.d/$BIN.fish"
    ./$BIN completion zsh  | install -Dm644 /dev/stdin "$pkgdir/usr/share/zsh/site-functions/_$BIN"
}
