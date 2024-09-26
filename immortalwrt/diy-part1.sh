#!/bin/bash
#
#自行编译时，会出现内核的魔法值不一样，需要完成如下修改：
#获取值
# curl -s https://downloads.openwrt.org/releases/23.05.2/targets/x86/64/openwrt-23.05.2-x86-64.manifest | grep kernel | awk '{print $3}' | awk -F- '{print $3}' > vermagic
# #修改内核配置文件
# sed -i '121s/^/#/' include/kernel-defaults.mk
# sed -i '121a\    cp $(TOPDIR)/vermagic $(LINUX_DIR)/.vermagic' include/kernel-defaults.mk

# sed -i '1,4s/^/#/' feeds.conf.default

# sed -i '1 i src-git telephony https://github.com/openwrt/telephony.git^86af194' feeds.conf.default
# sed -i '1 i src-git routing https://github.com/openwrt/routing.git^0617824' feeds.conf.default
# sed -i '1 i src-git luci https://github.com/immortalwrt/luci.git^7ce5799365' feeds.conf.default
# sed -i '1 i src-git packages https://github.com/immortalwrt/packages.git^fc5c6d19b' feeds.conf.default

echo "run scripts update && install"

./scripts/feeds update -a
./scripts/feeds install -a

echo "remove packages"
# 替换的包 

#istore
rm -rf package/istore
git clone https://github.com/linkease/istore package/istore

# #OpenAppFilter
# git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

#lucky
rm -rf package/lucky
git clone  https://github.com/gdy666/luci-app-lucky.git package/lucky

# luci-app-eqosplus
rm -rf package/luci-app-eqosplus
git clone https://github.com/sirpdboy/luci-app-eqosplus package/luci-app-eqosplus

# 添加turboacc
rm -rf package/turboacc
curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh
rm -rf package/turboacc/nft-fullcone
# luci-app-adguardhome
rm -rf package/luci-app-adguardhome
git clone https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome

# #wwan-packages
# rm -rf package/awwan-packages
# git clone https://github.com/immortalwrt/wwan-packages.git package/awwan-packages




