# shellcheck shell=bash disable=SC2034,SC2154

_z_binname="${_CARVEL_BINNAME:?}"
_github_repo="carvel-dev/${_CARVEL_PROJECT:?}"

_gh_info=$(pkgb:get_github_info "$_github_repo")
if [[ -n "$_gh_info" ]]; then
    eval "$_gh_info"
    pkgver="${pkgver#v}"
else
    log::error "Failed to get info from GitHub"
fi

provides=($_z_binname)
arch=(x86_64 aarch64)

_tmp_file="$(mktemp)"
gh release view \
    --repo "$_github_repo" \
    --json assets,body,tagName \
    >"$_tmp_file"
for _arch_pkg in "${arch[@]}"; do
    case "$_arch_pkg" in
        x86_64) _arch_bin=amd64 ;;
        aarch64) _arch_bin=arm64 ;;
    esac

    _source="$( \
       jq --raw-output \
         --exit-status \
         --arg tool "$_z_binname" \
         --arg arch "$_arch_bin" \
         '$tool + "-" + .tagName + "::" + (.assets[] | select(.name == $tool + "-linux-" + $arch) | .url)' \
         <"$_tmp_file")"
    declare -a "source_$_arch_pkg=('$_source')"

    _hashsum="$(jq --raw-output '.body' <"$_tmp_file" | grep -F "linux-$_arch_bin" | awk '{print $1}')"
    declare -a "sha256sums_$_arch_pkg=('$_hashsum')"
done


package() {
    install -Dm 755 "${srcdir}/${_z_binname}-v${pkgver}" "${pkgdir}/usr/bin/${_z_binname}"

    mkdir -p "$pkgdir/usr/share/bash-completion/completions/";
    mkdir -p "$pkgdir/usr/share/zsh/site-functions/";
    mkdir -p "$pkgdir/usr/share/fish/vendor_completions.d/";
    ./$_z_binname completion bash | install -Dm644 /dev/stdin "$pkgdir/usr/share/bash-completion/completions/$_z_binname";
    ./$_z_binname completion fish | install -Dm644 /dev/stdin "$pkgdir/usr/share/fish/vendor_completions.d/$_z_binname.fish";
    ./$_z_binname completion zsh | install -Dm644 /dev/stdin "$pkgdir/usr/share/zsh/site-functions/_$_z_binname"
}
