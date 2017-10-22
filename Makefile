TESTVM := $(if $(TESTVM),$(TESTVM),terraform)
VAGRANTFILE=$(TESTVM:%=Vagrantfile.%.rb)

help:
	@echo "VM_IP=1.1.1.1 make create - create new example VM"
	@echo "VM_IP=1.1.1.1 make recreate - recreate example VM"
	@echo "   default VM_IP value is 192.168.56.123"
	@echo "make destroy - destroy example VM"
	@echo "make terraform - apply terraform config"


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

terraform:
	cd terraform ;\
	terraform init ;\
	terraform apply ;\
	curl -s $(terraform output lb_ip)

.PHONY: help create recreate destroy terraform
