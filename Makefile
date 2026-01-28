# MAKEFLAGS += --no-builtin-rules
.SUFFIXES:

DAEMON_BASE_PATH := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

BR2_DL_DIR = $(DAEMON_BASE_PATH)/dl
OUTPUT_BASEDIR = $(DAEMON_BASE_PATH)/output
OUTPUT_DIR = $(OUTPUT_BASEDIR)/$(patsubst %_defconfig,%,$@)

MAKE_BUILDROOT = $(MAKE) -C $(DAEMON_BASE_PATH)/buildroot BR2_EXTERNAL=$(DAEMON_BASE_PATH)/daemon-buildroot

%: $(DAEMON_BASE_PATH)/daemon-buildroot/configs/%
	$(MAKE_BUILDROOT) O=$(OUTPUT_DIR) $@
	sed -i /^BR2_DL_DIR=.*/s%%BR2_DL_DIR=$(BR2_DL_DIR)% $(OUTPUT_DIR)/.config

SUBDIRS := $(wildcard $(OUTPUT_BASEDIR)/*)

all: $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@

.PHONY: all $(SUBDIRS)

clean:
	rm -rf $(OUTPUT_BASEDIR) $(BR2_DL_DIR)
