update-submodules::
	git submodule update --init --recursive

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
	$(MAKE) -C $* update
