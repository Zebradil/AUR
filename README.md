# AUR

AUR (Arch User Repository) packages that I maintain.

## Requirements

Depending on what you want to do, you may need the following tools/packages:

- bash 5
- curl
- diffutils
- docker
- docker-compose
- go-task
- jq
- pacman-contrib
- sed

## Packages

<!-- BEGIN MAINTAINED_PACKAGES -->
| Package | Version | AUR | Description |
| ------- | ------- | --- | ----------- |
| [alacritty-colorscheme-git](https://github.com/zebradil/alacritty-colorscheme/) | r51.257e466-2 | [link](https://aur.archlinux.org/packages/alacritty-colorscheme-git) | Change colorscheme of alacritty with ease |
| [carvel-tools](https://carvel.dev) | 20250527-1 | [link](https://aur.archlinux.org/packages/carvel-tools) | Deprecated: install carvel tools separately |
| [cloudflare-dynamic-dns](https://github.com/zebradil/cloudflare-dynamic-dns) | 4.3.17-1 | [link](https://aur.archlinux.org/packages/cloudflare-dynamic-dns) | Updates AAAA records at Cloudflare according to the current IPv6 address |
| [cloudflare-dynamic-dns-bin¹](https://github.com/zebradil/cloudflare-dynamic-dns) | 4.3.17-1 | [link](https://aur.archlinux.org/packages/cloudflare-dynamic-dns-bin) | Dynamic DNS client for Cloudflare with IPv6/IPv4 support |
| [gke-kubeconfiger-bin¹](https://github.com/zebradil/gke-kubeconfiger) | 0.7.42-1 | [link](https://aur.archlinux.org/packages/gke-kubeconfiger-bin) | Setup kubeconfigs for all accessible GKE clusters. |
| [imgpkg](https://carvel.dev/imgpkg) | 0.46.1-1 | [link](https://aur.archlinux.org/packages/imgpkg) | Store application configuration files in Docker/OCI registries |
| [imgpkg-bin](https://carvel.dev/imgpkg) | 0.46.1-1 | [link](https://aur.archlinux.org/packages/imgpkg-bin) | Store application configuration files in Docker/OCI registries |
| [kapp](https://carvel.dev/kapp) | 0.64.2-1 | [link](https://aur.archlinux.org/packages/kapp) | kapp is a simple deployment tool focused on the concept of "Kubernetes application" — a set of resources with the same label |
| [kapp-bin](https://carvel.dev/kapp) | 0.64.2-1 | [link](https://aur.archlinux.org/packages/kapp-bin) | kapp is a simple deployment tool focused on the concept of "Kubernetes application" — a set of resources with the same label |
| [kbld](https://carvel.dev/kbld) | 0.46.0-1 | [link](https://aur.archlinux.org/packages/kbld) | kbld seamlessly incorporates image building and image pushing into your development and deployment workflows |
| [kbld-bin](https://carvel.dev/kbld) | 0.46.0-1 | [link](https://aur.archlinux.org/packages/kbld-bin) | kbld seamlessly incorporates image building and image pushing into your development and deployment workflows |
| [kctrl](https://carvel.dev/kapp-controller) | 0.58.0-1 | [link](https://aur.archlinux.org/packages/kctrl) | Continuous delivery and package management for Kubernetes. |
| [kctrl-bin](https://carvel.dev/kapp-controller) | 0.58.0-1 | [link](https://aur.archlinux.org/packages/kctrl-bin) | Continuous delivery and package management for Kubernetes. |
| [kuttle¹](https://github.com/kayrus/kuttle) | 1.1.1-1 | [link](https://aur.archlinux.org/packages/kuttle) | Kubernetes wrapper for sshuttle |
| [kwt](https://github.com/carvel-dev/kwt) | 0.0.8-4 | [link](https://aur.archlinux.org/packages/kwt) | Kubernetes Workstation Tools CLI |
| [kwt-bin](https://github.com/carvel-dev/kwt) | 0.0.8-10 | [link](https://aur.archlinux.org/packages/kwt-bin) | Kubernetes Workstation Tools CLI |
| [myks-bin¹](https://github.com/mykso/myks) | 4.11.2-1 | [link](https://aur.archlinux.org/packages/myks-bin) | Configuration framework for Kubernetes applications |
| [pdfrrr¹](https://github.com/zebradil/pdfrrr) | 1.1.1-1 | [link](https://aur.archlinux.org/packages/pdfrrr) | Rotate pdf pages automatically |
| [python-powerline-taskwarrior](https://github.com/Zebradil/powerline-taskwarrior) | 2.0.0-18 | [link](https://aur.archlinux.org/packages/python-powerline-taskwarrior) | Powerline segment for showing information from Taskwarrior task manager |
| [rustotpony](https://github.com/zebradil/rustotpony) | 0.5.5-2 | [link](https://aur.archlinux.org/packages/rustotpony) | RusTOTPony — CLI manager of one-time password generators like Google Authenticator |
| [rustotpony-bin](https://github.com/zebradil/rustotpony) | 0.5.5-2 | [link](https://aur.archlinux.org/packages/rustotpony-bin) | RusTOTPony — CLI manager of one-time password generators like Google Authenticator |
| [vendir](https://carvel.dev/vendir) | 0.44.0-1 | [link](https://aur.archlinux.org/packages/vendir) | Easy way to vendor portions of git repos, github releases, helm charts, docker image contents, etc. declaratively |
| [vendir-bin](https://carvel.dev/vendir) | 0.44.0-1 | [link](https://aur.archlinux.org/packages/vendir-bin) | Easy way to vendor portions of git repos, github releases, helm charts, docker image contents, etc. declaratively |
| [xkb-switch-i3](https://github.com/zebradil/xkb-switch-i3) | 2.0.1+i3_5-9 | [link](https://aur.archlinux.org/packages/xkb-switch-i3) | Program that allows to query and change the XKB layout state (with i3wm auto-switch mode) |
| [xkb-switch-i3-git](https://github.com/zebradil/xkb-switch-i3) | 2.0.1+i3_5-6 | [link](https://aur.archlinux.org/packages/xkb-switch-i3-git) | Program that allows to query and change the XKB layout state (with i3wm auto-switch mode) |
| [ytt](https://carvel.dev/ytt) | 0.52.0-1 | [link](https://aur.archlinux.org/packages/ytt) | YAML templating tool that works on YAML structure instead of text |
| [ytt-bin](https://carvel.dev/ytt) | 0.52.0-1 | [link](https://aur.archlinux.org/packages/ytt-bin) | YAML templating tool that works on YAML structure instead of text |

¹ - Package is maintained in the AUR but not in this repository.
    Check the PKGBUILD file of the package for more information.
<!-- END MAINTAINED_PACKAGES -->

## Credits

Parts of the implementation are based on or inspired by the following projects:

- [KSXGitHub/github-actions-deploy-aur](https://github.com/KSXGitHub/github-actions-deploy-aur)
