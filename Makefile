include $(shell git rev-parse --show-toplevel)/.bootstrap.mk

all:: submodules ## Updates all packages, commits and pushes changes
	for d in `ls pkg`
	do
		$(MAKE) -C pkg/$$d update
	done
	for d in $$(git diff --name-only --diff-filter=ACMR)
	do
		(cd $$d; git commit -am 'Update'; git push)
	done
	git commit -am 'Update'
	git push

submodules:: ## Updates submodules
	git submodule update --recursive

update-carvel-tools:: ## Update carvel-tools
update-docoseco:: ## Update docoseco
update-kubectl-gke-rapid-bin:: ## Update kubectl-gke-rapid-bin
update-kubectl-gke-regular-bin:: ## Update kubectl-gke-regular-bin
update-kubectl-gke-stable-bin:: ## Update kubectl-gke-stable-bin
update-ruby-sequel:: ## Update ruby-sequel
update-rustotpony:: ## Update rustotpony
update-rustotpony-bin:: ## Update rustotpony-bin
update-xkb-switch-i3:: ## Update xkb-switch-i3
update-xkb-switch-i3-git:: ## Update xkb-switch-i3-git
update-%::
	$(MAKE) -C pkg/$* update

