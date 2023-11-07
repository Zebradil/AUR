FROM ghcr.io/archlinux/archlinux:base-20231107.0.190206

RUN pacman -Suy --needed --noconfirm \
  git \
  github-cli \
  jq \
  pacman-contrib \
  sudo

RUN useradd -m -s /bin/bash nonroot
