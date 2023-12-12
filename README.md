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
| [alacritty-colorscheme-git](https://github.com/zebradil/alacritty-colorscheme/) | r51.257e466-1 | [link](https://aur.archlinux.org/packages/alacritty-colorscheme-git) | Change colorscheme of alacritty with ease |
| [carvel-tools](https://carvel.dev) | 20231206-1 | [link](https://aur.archlinux.org/packages/carvel-tools) | Set of Carvel tools (binaries): imgpkg kapp kbld kctrl kwt vendir ytt |
| [cloudflare-dynamic-dns](https://github.com/zebradil/cloudflare-dynamic-dns) | 2.3.6-1 | [link](https://aur.archlinux.org/packages/cloudflare-dynamic-dns) | Updates AAAA records at Cloudflare according to the current IPv6 address |
| [cloudflare-dynamic-dns-bin¹](https://github.com/Zebradil/cloudflare-dynamic-dns) | 2.3.2-1 | [link](https://aur.archlinux.org/packages/cloudflare-dynamic-dns-bin) | Updates AAAA records at Cloudflare according to the current IPv6 address |
| [imgpkg](https://carvel.dev/imgpkg) | 0.39.0-3 | [link](https://aur.archlinux.org/packages/imgpkg) | Store application configuration files in Docker/OCI registries |
| [imgpkg-bin](https://carvel.dev/imgpkg) | 0.39.0-5 | [link](https://aur.archlinux.org/packages/imgpkg-bin) | Store application configuration files in Docker/OCI registries |
| [kapp-bin](https://carvel.dev/kapp) | 0.59.1-5 | [link](https://aur.archlinux.org/packages/kapp-bin) | kapp is a simple deployment tool focused on the concept of "Kubernetes application" — a set of resources with the same label |
| [kbld](https://carvel.dev/kbld) | 0.38.1-2 | [link](https://aur.archlinux.org/packages/kbld) | kbld seamlessly incorporates image building and image pushing into your development and deployment workflows |
| [kbld-bin](https://carvel.dev/kbld) | 0.38.1-5 | [link](https://aur.archlinux.org/packages/kbld-bin) | kbld seamlessly incorporates image building and image pushing into your development and deployment workflows |
| [kubectl-gke-rapid-bin](https://github.com/kubernetes/kubectl) | v1.28.4-1 | [link](https://aur.archlinux.org/packages/kubectl-gke-rapid-bin) | Kubernetes.io client binary, compatible with the GKE version from the rapid channel |
| [kubectl-gke-regular-bin](https://github.com/kubernetes/kubectl) | v1.24.17-4 | [link](https://aur.archlinux.org/packages/kubectl-gke-regular-bin) | Kubernetes.io client binary, compatible with the GKE version from the regular channel |
| [kubectl-gke-stable-bin](https://github.com/kubernetes/kubectl) | v1.24.17-4 | [link](https://aur.archlinux.org/packages/kubectl-gke-stable-bin) | Kubernetes.io client binary, compatible with the GKE version from the stable channel |
| [kuttle¹](https://github.com/kayrus/kuttle) | 1.1.1-1 | [link](https://aur.archlinux.org/packages/kuttle) | Kubernetes wrapper for sshuttle |
| [kwt](https://github.com/carvel-dev/kwt) | 0.0.8-2 | [link](https://aur.archlinux.org/packages/kwt) | Kubernetes Workstation Tools CLI |
| [kwt-bin](https://github.com/carvel-dev/kwt) | 0.0.8-5 | [link](https://aur.archlinux.org/packages/kwt-bin) | Kubernetes Workstation Tools CLI |
| [myks-bin¹](https://github.com/mykso/myks) | 2.2.0-1 | [link](https://aur.archlinux.org/packages/myks-bin) | A configuration framework for Kubernetes applications |
| [pdfrrr¹](https://github.com/zebradil/pdfrrr) | 1.1.1-1 | [link](https://aur.archlinux.org/packages/pdfrrr) | Rotate pdf pages automatically |
| [python-powerline-taskwarrior](https://github.com/Zebradil/powerline-taskwarrior) | 2.0.0-17 | [link](https://aur.archlinux.org/packages/python-powerline-taskwarrior) | Powerline segment for showing information from Taskwarrior task manager |
| [rustotpony](https://github.com/zebradil/rustotpony) | 0.4.4-2 | [link](https://aur.archlinux.org/packages/rustotpony) | RusTOTPony — CLI manager of one-time password generators like Google Authenticator |
| [rustotpony-bin](https://github.com/zebradil/rustotpony) | 0.4.4-2 | [link](https://aur.archlinux.org/packages/rustotpony-bin) | RusTOTPony — CLI manager of one-time password generators like Google Authenticator |
| [vendir](https://carvel.dev/vendir) | 0.38.0-1 | [link](https://aur.archlinux.org/packages/vendir) | Easy way to vendor portions of git repos, github releases, helm charts, docker image contents, etc. declaratively |
| [vendir-bin](https://carvel.dev/vendir) | 0.38.0-1 | [link](https://aur.archlinux.org/packages/vendir-bin) | Easy way to vendor portions of git repos, github releases, helm charts, docker image contents, etc. declaratively |
| [xkb-switch-i3](https://github.com/zebradil/xkb-switch-i3) | 2.0.1+i3_5-8 | [link](https://aur.archlinux.org/packages/xkb-switch-i3) | Program that allows to query and change the XKB layout state (with i3wm auto-switch mode) |
| [xkb-switch-i3-git](https://github.com/zebradil/xkb-switch-i3) | 2.0.1+i3_5-5 | [link](https://aur.archlinux.org/packages/xkb-switch-i3-git) | Program that allows to query and change the XKB layout state (with i3wm auto-switch mode) |
| [ytt-bin](https://carvel.dev/ytt) | 0.46.2-4 | [link](https://aur.archlinux.org/packages/ytt-bin) | YAML templating tool that works on YAML structure instead of text |

¹ - Package is maintained in the AUR but not in this repository.
    Check the PKGBUILD file of the package for more information.
<!-- END MAINTAINED_PACKAGES -->

## Credits

Parts of the implementation are based on or inspired by the following projects:

- [KSXGitHub/github-actions-deploy-aur](https://github.com/KSXGitHub/github-actions-deploy-aur)
