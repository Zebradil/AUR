# shellcheck shell=bash

log::group() {
    echo "::group::$*"
}

log::endgroup() {
    echo "::endgroup::"
}

log::debug() {
    echo "::debug::$*"
}

log::info() {
    echo "::notice::$*"
}

log::warn() {
    echo "::warning::$*"
}

log::error() {
    echo "::error::$*"
}
