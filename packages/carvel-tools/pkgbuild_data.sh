# shellcheck disable=SC2034,SC2154

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

pkgname=carvel-tools
pkgver=$(date +%Y%m%d)
arch=(x86_64 aarch64)
pkgdesc="Set of Carvel tools (binaries): ${_tools[*]}"
url="https://carvel.dev"
license=(Apache)
provides=("${_tools[@]}")
conflicts=("${_tools[@]}")


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

            jq --raw-output '.body' <"${tmp_file}" \
                | grep -F "linux-${arch_bin}" \
                | awk '{print $1}' \
                >>"${_tmpdir}/_hashsum_${arch_pkg}"
        done
    done
}

_retrieve_data

for a in "${arch[@]}"; do
    readarray -t "source_$a" < <(cat "${_tmpdir}/_source_$a")
    readarray -t "sha256sums_$a" < <(cat "${_tmpdir}/_hashsum_$a")
done

_gen_package(){
    local bin_name

    echo "package() {"
    for tool in "${_tools[@]}"; do
        bin_name=$(grep -E "^${tool}[^:]+" -o "${_tmpdir}/_source_x86_64")
        # shellcheck disable=SC2016
        echo 'install -Dm 755 "${srcdir}/'"${bin_name}"'" "${pkgdir}/usr/bin/'"${tool}"'"'
    done
    echo "}"
}

eval "$(_gen_package)"
