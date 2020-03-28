.PHONY: bootstrap, package-and-import

bootstrap:
	test -d rootfs && sudo rm -rf rootfs && mkdir rootfs || true
	sudo distrobuilder build-dir distrobuilder.yaml rootfs

package-and-import:
	sudo distrobuilder pack-lxd distrobuilder.yaml rootfs/ artifacts/
	lxc image delete corsac-ubuntu-image
	lxc image import artifacts/lxd.tar.xz corsac-ubuntu-image/rootfs.squashfs --alias corsac-ubuntu-image
