pkgb:header() {
    local -n _contributors="$1"
    echo '# Maintainer: German Lashevich <german.lashevich@gmail.com>'
    if [[ -n "$_contributors" ]]; then
        for contributor in "${_contributors[@]}"; do
            echo "# Contributor: $contributor"
        done
    fi
    cat <<EOF
#
# Source: https://github.com/zebradil/aur
#
# shellcheck disable=SC2034,SC2154
EOF
}

pkgb:get_latest_github_release() {
    curl -fsSL \
        "https://api.github.com/repos/$1/releases/latest" \
        --header "Authorization: Bearer ${GITHUB_TOKEN:?}" \
        | jq -r '.tag_name'
}

pkgb:print_arr_by_name() {
    local name="$1"
    local -n arr="$name"
    if [[ -n "${arr:-}" ]]; then
        echo "$name=(${arr[@]})"
    fi
}
