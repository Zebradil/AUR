# shellcheck shell=bash disable=SC2034,SC2154

# Source code:
# - https://github.com/carvel-dev/imgpkg
# - https://github.com/carvel-dev/kapp
# - https://github.com/carvel-dev/kbld
# - https://github.com/carvel-dev/kapp-controller
# - https://github.com/carvel-dev/kwt
# - https://github.com/carvel-dev/vendir
# - https://github.com/carvel-dev/ytt

set -euo pipefail

_tmpdir=$(mktemp -d)
_tools=(imgpkg kapp kbld kctrl kwt vendir ytt)
_tools_completions=(imgpkg kapp kctrl vendir ytt)

pkgname=carvel-tools
pkgver=$(date +%Y%m%d)
arch=(x86_64 aarch64)
pkgdesc='Deprecated: install carvel tools separately'
url="https://carvel.dev"
license=(Apache)
provides=("${_tools[@]}")
conflicts=("${_tools[@]}")
install='0.install'
_z_assets=("$install")

_retrieve_data() {
    local project
    local tmp_file
    local arch_bin

    for tool in "${_tools[@]}"; do
        if [[ $tool == kctrl ]]; then
            project=kapp-controller
        else
            project="$tool"
        fi

        tmp_file="${_tmpdir}/${tool}"
        gh release view \
            --repo "carvel-dev/${project}" \
            --json assets,body,name,publishedAt \
            >"${tmp_file}"

        for arch_pkg in "${arch[@]}"; do
            case "${arch_pkg}" in
            x86_64) arch_bin=amd64 ;;
            aarch64) arch_bin=arm64 ;;
            esac

            jq --raw-output \
                --exit-status \
                --arg tool "$tool" \
                --arg arch "$arch_bin" \
                '$tool + "-" + .name + "::" + (.assets[] | select(.name == $tool + "-linux-" + $arch) | .url)' \
                <"${tmp_file}" \
                >>"${_tmpdir}/_source_${arch_pkg}"

            jq --raw-output '.body' <"${tmp_file}" |
                sed --silent --regexp-extended "s/^([a-z0-9]{64})\s+.*linux-$arch_bin.*$/\1/p" \
                    >>"${_tmpdir}/_hashsum_${arch_pkg}"
        done
    done
}

_retrieve_data

for a in "${arch[@]}"; do
    readarray -t "source_$a" < <(cat "${_tmpdir}/_source_$a")
    readarray -t "sha256sums_$a" < <(cat "${_tmpdir}/_hashsum_$a")
done

_gen_package() {
    local bin_name

    echo "package() {"
    echo 'set -eo pipefail'
    echo 'mkdir -p "$pkgdir/usr/share/bash-completion/completions/"'
    echo 'mkdir -p "$pkgdir/usr/share/zsh/site-functions/"'
    echo 'mkdir -p "$pkgdir/usr/share/fish/vendor_completions.d/"'
    for tool in "${_tools[@]}"; do
        bin_name=$(grep -E "^${tool}[^:]+" -o "${_tmpdir}/_source_x86_64")
        echo 'install -Dm 755 "${srcdir}/'"${bin_name}"'" "${pkgdir}/usr/bin/'"${tool}"'"'
        if [[ "${_tools_completions[*]}" =~ "${tool}" ]]; then
            echo '"${pkgdir}/usr/bin/'"${tool}"'" completion bash | install -Dm644 /dev/stdin "${pkgdir}/usr/share/bash-completion/completions/${pkgname}-'"${tool}"'"'
            echo '"${pkgdir}/usr/bin/'"${tool}"'" completion fish | install -Dm644 /dev/stdin "${pkgdir}/usr/share/fish/vendor_completions.d/${pkgname}-'"${tool}"'.fish"'
            echo '"${pkgdir}/usr/bin/'"${tool}"'" completion zsh  | install -Dm644 /dev/stdin "${pkgdir}/usr/share/zsh/site-functions/_${pkgname}-'"${tool}"'"'
        fi
    done
    echo "}"
}

eval "$(_gen_package)"
