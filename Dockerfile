FROM ghcr.io/archlinux/archlinux:base-devel-20261008.0.608774@sha256:827747df8aa5678c1694ab9c0974abde585d0efbf2a72bd71fff176df5ae1299

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN --mount=type=cache,target=/var/cache/pacman/pkg \
    pacman -Suy --noconfirm --needed --overwrite '*' \
      diffutils \
      git \
      github-cli \
      jq \
      openssh \
      pacman-contrib

# Install common package make dependencies
# hadolint ignore=DL3059
RUN --mount=type=cache,target=/var/cache/pacman/pkg \
    pacman -Suy --noconfirm --needed --overwrite '*' \
      go

# Install yay from GitHub
# renovate: datasource=github-releases depName=Jguer/yay
ARG YAY_VERSION=v13.0.1
RUN --mount=type=tmpfs,target=/tmp \
    curl -sSfL \
      https://github.com/Jguer/yay/releases/download/${YAY_VERSION}/yay_${YAY_VERSION#v}_x86_64.tar.gz \
        | tar -xzC /tmp --strip-components=1 \
 && mv /tmp/yay /usr/local/bin/yay

ARG APP_ROOT=/app
ARG BIN_DIR="${APP_ROOT}/scripts/bin"

ENV APP_USER=builder
ENV APP_ROOT="${APP_ROOT}"
ENV PATH="${BIN_DIR}:${PATH}"

COPY --link . "${APP_ROOT}"

RUN docker_prepare

# hadolint ignore=DL3059
RUN ln -s "$BIN_DIR/docker_entrypoint" /docker_entrypoint
ENTRYPOINT ["/docker_entrypoint"]
