TEST_DAEMON_VERSION = 0.0.1
TEST_DAEMON_SITE = $(BR2_EXTERNAL)/../test-daemon
TEST_DAEMON_SITE_METHOD = local
TEST_DAEMON_DEPENDENCIES = host-zig

define TEST_DAEMON_BUILD_CMDS
	# Figure out how to get the target arch
	$(MAKE) -C $(@D) ZIG=$(HOST_ZIG_ZIG_BIN) ZIG_FLAGS="-Dtarget=aarch64-$(TARGET_OS)-gnu -Doptimize=Debug -Dproto-path=$(BR2_EXTERNAL)/../daemon-protobuf/ --sysroot $(STAGING_DIR) --search-prefix /usr"
endef

define TEST_DAEMON_INSTALL_TARGET_CMDS
	cp $(@D)/zig-out/bin/test-daemon $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))
