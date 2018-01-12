# General

It's a small demo. Also you can read [it](https://habrahabr.ru/post/340884/)
1. Create [VirtualBox](https://www.virtualbox.org/) VM via [Vagrant](https://www.vagrantup.com/)
2. Provision VM via [Ansible](https://www.ansible.com/)
3. Install [minikube](https://github.com/kubernetes/minikube)
4. Check VM provision via [serverspec](http://serverspec.org/)
5. Setup hello-world application via [terraform](https://www.terraform.io/)

Also you can read [howto](https://habrahabr.ru/post/340884/) use it and deploy to [cloud.google.com/](https://cloud.google.com/)

# Prepare

Before run please install:
1. [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Vagrant](https://www.vagrantup.com/downloads.html)

# Run it

```
vagrant up
```

This will create a virtual machine with the specified IP address (`192.168.56.123`), also it will copy your public SSH key if it exists.

## VM custom IP

```
VM_IP=1.1.1.1 make recreate
```
