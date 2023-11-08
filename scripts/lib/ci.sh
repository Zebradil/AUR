# shellcheck shell=bash

LIB_DIR="$(dirname "${BASH_SOURCE[0]}")"
source "$LIB_DIR/ga_logger.sh"

ci::set_git_user() {
    log::group "Setting git user..."
    local username="${1:?username is required}"
    local email="${2:?email is required}"
    git config --global user.name "$username"
    git config --global user.email "$email"
    log::endgroup
}

ci::assert_non_empty() {
    name=${1:?name is required}
    value=${2:?value is required}
    if [[ -z "$value" ]]; then
        log::error "Invalid Value: $name is empty."
        exit 1
    fi
}

ci::assert_boolean() {
    name=${1:?name is required}
    value=${2:?value is required}
    if [[ $value != "true" && $value != "false" ]]; then
        log::error "Invalid Value: $name is neither 'true' nor 'false': '$value'"
        exit 1
    fi
}

ci::import_ssh_key(){
    local ssh_private_key="${1:?ssh_private_key is required}"
    log::group 'Importing private key'
    echo "$ssh_private_key" >~/.ssh/aur
    ssh-keygen -vy -f ~/.ssh/aur >~/.ssh/aur.pub
    chmod -vR 600 ~/.ssh/aur*
    log::info "SSH key fingerprint: $(ssh-keygen -lf ~/.ssh/aur)"
    log::endgroup
}
