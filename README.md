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
| [kapp](https://carvel.dev/kapp) | 0.65.3-1 | [link](https://aur.archlinux.org/packages/kapp) | kapp is a simple deployment tool focused on the concept of "Kubernetes application" — a set of resources with the same label |
| [ytt](https://carvel.dev/ytt) | 0.55.1-1 | [link](https://aur.archlinux.org/packages/ytt) | YAML templating tool that works on YAML structure instead of text |

¹ - Package is maintained in the AUR but not in this repository.
    Check the PKGBUILD file of the package for more information.
<!-- END MAINTAINED_PACKAGES -->

## Credits

Parts of the implementation are based on or inspired by the following projects:

- [KSXGitHub/github-actions-deploy-aur](https://github.com/KSXGitHub/github-actions-deploy-aur)
