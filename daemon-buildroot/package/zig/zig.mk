ZIG_VERSION = 0.15.1
ZIG_OS = linux
ZIG_ARCH = x86_64
ZIG_SOURCE = zig-$(ZIG_ARCH)-$(ZIG_OS)-$(ZIG_VERSION).tar.xz
ZIG_SITE = https://ziglang.org/download/$(ZIG_VERSION)
ZIG_LICENSE = MIT
ZIG_LICENSE_FILE = LICENSE

define HOST_ZIG_INSTALL_CMDS
	cp -r $(@D)/lib $(HOST_DIR)/usr/lib/zig
	cp $(@D)/zig $(HOST_DIR)/usr/bin
endef

HOST_ZIG_ZIG_BIN = $(HOST_DIR)/usr/bin/zig

$(eval $(host-generic-package))

