# infrastructure

my infrastructure as code. contains personal configuration

here is a rough primitive soon-to-be-current architecture overview

![architecture](./assets/primitive-plan.png)

the git logo represents an origin of frequent provisioning operations

the plan is to create ubuntu lxd machine containers on several of my physical machines, geared towards either storage or processing, and build either a ceph and kubernetes cluster or an opennebula cloud environment on top of that

## installation

```sh
git clone https://github.com/eankeen/corsac
cd "corsac/$folder"
make bootstrap
make ${folder-specific-command}
```
