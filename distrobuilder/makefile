.PHONY: bootstrap, package-and-import

bootstrap:
	sudo distrobuilder build-dir distrobuilder.yaml rootfs

package-and-import:
	sudo distrobuilder pack-lxd distrobuilder.yaml rootfs/ corsac-ubuntu-image
	lxc image delete corsac-ubuntu-image
	lxc image import corsac-ubuntu-image/lxd.tar.xz corsac-ubuntu-image/rootfs.squashfs --alias corsac-ubuntu-image
