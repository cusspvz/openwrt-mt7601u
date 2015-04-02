#
# Copyright (C) 2007-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=mt7601u
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/kuba-moo/mt7601u.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=5dae22687b9974356930f1150d6db09b79b2a229
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz

PKG_BUILD_PARALLEL:=1

PKG_MAINTAINER:=José Moreira <josemoreiravarzim@gmail.com>

include $(INCLUDE_DIR)/package.mk

WMENU:=Wireless Drivers

define KernelPackage/mt7601u
	SUBMENU:=Wireless Drivers
	TITLE:=Driver for MT7601U wireless adapters
	FILES:=$(PKG_BUILD_DIR)/mt7601u.$(LINUX_KMOD_SUFFIX)
	DEPENDS:=+wireless-tools +kmod-mac80211 @USB_SUPPORT @LINUX_3_X
	AUTOLOAD:=$(call AutoProbe,mt7601u)
endef

define KernelPackage/mt7601u/description
  This package contains a rewritten driver for usb wireless adapters based on the mediatek MT7601U chip by kuba-moo
endef

MT7601U_MAKEOPTS= -C $(PKG_BUILD_DIR) \
	KERNELRELEASE="$(LINUX_VERSION)" \
	KDIR="(KERNEL_BUILD_DIR)" \
	TARGET="$(HAL_TARGET)" \
	ARCH="$(LINUX_KARCH)"

define Build/Compile
	$(MAKE) $(MT7601U_MAKEOPTS)
endef

define KernelPackage/mt7601u/install
	$(INSTALL_DIR) $(1)/lib/modules/$(LINUX_VERSION)
endef

$(eval $(call KernelPackage,mt7601u))
