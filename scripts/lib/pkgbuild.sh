pkgb:header() {
    cat <<EOF
# Maintainer: German Lashevich <german.lashevich@gmail.com>
#
# Source: https://github.com/zebradil/aur
#
# shellcheck disable=SC2034,SC2154
EOF
}

pkgb:get_latest_github_release() {
curl -fsSL \
    "https://api.github.com/repos/zebradil/$1/releases/latest" \
    --header "Authorization: Bearer ${GITHUB_TOKEN:?}" \
    | jq -r '.tag_name'
}
