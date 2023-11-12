# shellcheck shell=bash

aur:download_file() {
    local pkgname="${1:?Specify package name}"
    local filename="${2:?Specify filename}"
    local url="https://aur.archlinux.org/cgit/aur.git/snapshot/$pkgname.tar.gz"
    curl -fsSL "$url" | tar -xzO "$pkgname/$filename"
}
