FROM ghcr.io/archlinux/archlinux:base-20231107.0.190206

RUN pacman -Suy --needed --noconfirm \
  git \
  pacman-contrib
