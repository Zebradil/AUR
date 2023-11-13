# shellcheck shell=bash

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

pkgb:get_latest_github_tag() {
    curl -fsSL \
        "https://api.github.com/repos/$1/tags" \
        --header "Authorization: Bearer ${GITHUB_TOKEN:?}" \
        | jq -r '.[] | .name' \
        | sort -V \
        | tail -1
}

pkgb:print_arr_by_name() {
    local name="$1"
    local -n arr="$name"
    if [[ -n "${arr:-}" ]]; then
        echo "$name=(${arr[@]})"
    fi
}

pkgb:get_github_info(){
    local jq_filter=$(
        cat <<EOF
            "pkgver='" + .latestRelease.tagName + "'",
            "pkgdesc='" + .description + "'",
            "url='" + .homepageUrl + "'",
            "_github_repo_url='" + .url + "'",
            "license=('" + .licenseInfo.key + "')"
EOF
    )

    gh repo view "${1:?GitHub repo is required}" \
        --json description,homepageUrl,latestRelease,licenseInfo,url \
        --jq "$jq_filter"
}
