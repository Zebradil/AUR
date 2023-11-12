# shellcheck shell=bash

: ${CHANNEL:?CHANNEL is not set}

kgke:get_major_version() {
    local channel="${1:?}"
    curl -fsSL \
        https://cloud.google.com/feeds/gke-$channel-channel-release-notes.xml \
        | sed -En 's/^.*v?([0-9]\.[0-9]+)\.[0-9]+-gke\.[0-9]+.*$/\1/p' \
        | head -n 1
}

kgke:get_version() {
    local major_version="${1:?}"
    curl -fsSL \
        https://gcsweb.k8s.io/gcs/kubernetes-release/release/stable-$major_version.txt
}

kgke:get_arches() {
    local version="${1:?}"
    curl -fsSL https://gcsweb.k8s.io/gcs/kubernetes-release/release/$version/bin/linux/ \
        | sed -En 's!^.*href=".*'"$version"'.*(386|amd64|arm|arm64)/".*$!\1!p'
}


pkgname="kubectl-gke-$CHANNEL-bin"
pkgver="$(kgke:get_version "$(kgke:get_major_version "$CHANNEL")")"
pkgdesc="Kubernetes.io client binary, compatible with the GKE version from the $CHANNEL channel"
provides=("$pkgname=$pkgver")
conflicts=($pkgname $pkgname-bin)
url="https://github.com/kubernetes/kubectl"
license=('Apache-2.0')

readarray -t arches < <(kgke:get_arches "$pkgver")
arch=()
for k_arch in "${arches[@]}"; do
    case $k_arch in
        386)
            p_arch=(i686)
            ;;
        amd64)
            p_arch=(x86_64)
            ;;
        arm)
            p_arch=(armv5 armv6h armv7h)
            ;;
        arm64)
            p_arch=(aarch64)
            ;;
        *)
            echo "Unsupported architecture: $a" >&2
            exit 1
            ;;
    esac

    base_url="https://storage.googleapis.com/kubernetes-release/release/$pkgver/bin/linux/$k_arch"

    for _a in "${p_arch[@]}"; do
        arch+=("$_a")
        declare -a "source_$_a=('$pkgname-$pkgver::$base_url/kubectl')"
        declare -a "sha256sums_$_a=('$(curl -fsSL $base_url/kubectl.sha256)')"
    done
done

package() {
    install -Dm755 "$srcdir/$pkgname-$pkgver" "$pkgdir/usr/bin/kubectl"
}
