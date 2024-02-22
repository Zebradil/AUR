# shellcheck shell=bash disable=SC2034,SC2154

pkgname=kctrl
_z_project_name="kapp-controller"
_github_repo="carvel-dev/$_z_project_name"

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

prepare() {
    set -eo pipefail

    cd "$_z_project_name-$pkgver/cli"

    sed -i "/^VERSION=/c\\VERSION=$pkgver" ./hack/build.sh
}

build() {
    set -eo pipefail

    cd "$_z_project_name-$pkgver/cli"

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

    cd "$_z_project_name-$pkgver/cli"

    BIN=$pkgname

    install -Dm755 $BIN -t "$pkgdir/usr/bin"
}
