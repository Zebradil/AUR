# shellcheck shell=bash

# shellcheck disable=SC2034
CHANNEL=rapid

# shellcheck source=../../scripts/lib/custom/kubectl_gke.sh
source "${LIB_DIR:?}/custom/kubectl_gke.sh"
