include $(shell git rev-parse --show-toplevel)/.bootstrap.mk

all:: submodules ## Updates all packages, commits and pushes changes
	printf "\033[0;33mUpdating packages:\033[0m\n"
	for d in `ls pkg`
	do
		printf "\n\033[0;32m$${d}\033[0m\n"
		git -C pkg/$$d reset HEAD --hard
		git -C pkg/$$d pull origin master
		$(MAKE) -C pkg/$$d update
	done
	printf "\n\033[0;33mCommitting and pushing changes:\033[0m\n"
	for d in $$(git diff --name-only --diff-filter=ACMR)
	do
		printf "\n\033[0;32m$${d}\033[0m\n"
		(cd $$d; git commit -am 'Update'; git push origin master)
	done
	printf "\n\033[0;32mMain repo\033[0m\n"
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

