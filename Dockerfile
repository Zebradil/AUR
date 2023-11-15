FROM ghcr.io/archlinux/archlinux:base-20231107.0.190206

RUN --mount=type=cache,target=/var/cache/pacman/pkg \
  pacman -Suy --noconfirm
RUN --mount=type=cache,target=/var/cache/pacman/pkg \
  pacman -Suy --noconfirm --needed --overwrite '*' \
      base-devel \
      diffutils \
      git \
      github-cli \
      jq \
      openssh \
      pacman-contrib

# Install common package make dependencies
RUN --mount=type=cache,target=/var/cache/pacman/pkg \
  pacman -Suy --noconfirm --needed --overwrite '*' \
      go

ARG APP_ROOT=/app
ARG BIN_DIR="${APP_ROOT}/scripts/bin"

ENV APP_USER=builder
ENV APP_ROOT="${APP_ROOT}"
ENV PATH="${BIN_DIR}:${PATH}"

COPY --link . "${APP_ROOT}"

RUN docker_prepare

RUN ln -s "$BIN_DIR/docker_entrypoint" /docker_entrypoint
ENTRYPOINT ["/docker_entrypoint"]
