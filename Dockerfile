FROM ghcr.io/archlinux/archlinux:base-devel-20261028.0.618050@sha256:e662899fb67476d18e8b7add1b8e022f86d0739cba03c3506b6d8e7f4f93a2be

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
ARG YAY_VERSION=v13.1.0
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
