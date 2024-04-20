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

ci::import_ssh_key() {
  local ssh_private_key="${1:?ssh_private_key is required}"
  local filepath="${2:-$HOME/.ssh/aur}"
  log::group 'Importing private key'
  log::info "SSH key path: $filepath"
  touch "$filepath"
  chmod -vR 600 "$filepath"
  echo "$ssh_private_key" >"$filepath"
  ssh-keygen -vy -f ~/.ssh/aur >"${filepath}.pub"
  log::info "SSH key fingerprint: $(ssh-keygen -lf "$filepath")"
  log::endgroup
}
