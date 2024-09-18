#!/bin/bash
#
#自行编译时，会出现内核的魔法值不一样，需要完成如下修改：
#获取值
curl -s https://downloads.openwrt.org/releases/23.05.2/targets/x86/64/openwrt-23.05.2-x86-64.manifest | grep kernel | awk '{print $3}' | awk -F- '{print $3}' > vermagic
#修改内核配置文件
sed -i '121s/^/#/' include/kernel-defaults.mk
sed -i '121a\    cp $(TOPDIR)/vermagic $(LINUX_DIR)/.vermagic' include/kernel-defaults.mk

sed -i '1,4s/^/#/' feeds.conf.default

sed -i '1 i src-git routing https://git.openwrt.org/feed/routing.git;openwrt-23.05' feeds.conf.default
sed -i '1 i src-git telephony https://git.openwrt.org/feed/telephony.git;openwrt-23.05' feeds.conf.default
sed -i '1 i src-git packages https://github.com/immortalwrt/packages.git;openwrt-23.05' feeds.conf.default
sed -i '1 i src-git luci https://github.com/immortalwrt/luci.git;openwrt-23.05' feeds.conf.default




echo "run scripts update && install"


./scripts/feeds update -a
./scripts/feeds install -a
