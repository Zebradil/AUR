include $(shell git rev-parse --show-toplevel)/.bootstrap.mk

all:: submodules
	for d in `ls pkg`
	do
		git -C pkg/$$d reset HEAD --hard
		git -C pkg/$$d pull origin master
		$(MAKE) -C pkg/$$d update
	done
	for d in $$(git diff --name-only --diff-filter=ACMR)
	do
		(cd $$d; git commit -am 'Update'; git push origin master)
	done
	git commit -am 'Update'
	git push

submodules::
	git submodule update --recursive

update-carvel-tools::
update-docoseco::
update-kubectl-gke-rapid-bin::
update-kubectl-gke-regular-bin::
update-kubectl-gke-stable-bin::
update-ruby-sequel::
update-rustotpony::
update-rustotpony-bin::
update-xkb-switch-i3::
update-xkb-switch-i3-git::
update-%::
	$(MAKE) -C pkg/$* update

