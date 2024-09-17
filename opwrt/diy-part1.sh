#!/bin/bash
#
#自行编译时，会出现内核的魔法值不一样，需要完成如下修改：
#获取值
curl -s https://downloads.openwrt.org/releases/23.05.4/targets/x86/64/openwrt-23.05.4-x86-64.manifest | grep kernel | awk '{print $3}' | awk -F- '{print $3}' > vermagic
#修改内核配置文件
sed -i '121s/^/#/' include/kernel-defaults.mk
sed -i '121a\    cp $(TOPDIR)/vermagic $(LINUX_DIR)/.vermagic' include/kernel-defaults.mk
echo "run scripts update && install"

sed -i '1i src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '2i src-git small https://github.com/kenzok8/small' feeds.conf.default


./scripts/feeds update -a
./scripts/feeds install -a
