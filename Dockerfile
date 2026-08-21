FROM ghcr.io/archlinux/archlinux:base-devel-20260821.0.577763@sha256:237475a90d086f7c3f2347d94d00e2417c7231fb54e81d8265a6259ea51b4491

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
