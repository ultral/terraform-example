# General

It's a small demo 
1. Create [VirtualBox](https://www.virtualbox.org/) VM via [Vagrant](https://www.vagrantup.com/)
2. Provision VM vi [ansible](https://www.ansible.com/)
3. Install [minikube](https://github.com/kubernetes/minikube)
4. Check VM provision via [serverspec](http://serverspec.org/)
5. Setup hello-world application via [terraform](https://www.terraform.io/)

# Prepare

Before run please install:
1. [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Vagrant](https://www.vagrantup.com/downloads.html)

# Run it

```
vagrant up
```

It will be created VM with default IP `192.168.56.123` and copy your public ssh key if exist.

## VM custom IP

```
VM_IP=1.1.1.1 make recreate
```
