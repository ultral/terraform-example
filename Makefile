TESTVM := $(if $(TESTVM),$(TESTVM),terraform)
VAGRANTFILE=$(TESTVM:%=Vagrantfile.%.rb)

example_destroy_$(VAGRANTFILE):
	VAGRANT_VAGRANTFILE='$(VAGRANTFILE)' vagrant destroy -f

example_start_$(VAGRANTFILE):
	VAGRANT_VAGRANTFILE='$(VAGRANTFILE)' vagrant up

example_provision_$(VAGRANTFILE):
	VAGRANT_VAGRANTFILE='$(VAGRANTFILE)' vagrant provision

example_recreate_$(VAGRANTFILE): example_destroy_$(VAGRANTFILE) example_start_$(VAGRANTFILE)

create: example_start_$(VAGRANTFILE)

provision: example_provision_$(VAGRANTFILE)

recreate: example_recreate_$(VAGRANTFILE)

destroy: example_destroy_$(VAGRANTFILE)

