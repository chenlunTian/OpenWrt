#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# 添加插件源码
# sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
# sed -i '$a src-git small8 https://github.com/kenzok8/small-package' feeds.conf.default
# add the diy 
sed -i '$a src-git helloworld https://github.com/fw876/helloworld.git' feeds.conf.default
# sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
# sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/lean/luci-app-argon-config
git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
git clone https://github.com/kenzok8/small.git package/small
git clone https://github.com/open-mesh-mirror/batman-adv.git package/batman-adv

### 修改为R4A千兆版Breed直刷版
## mt7621_xiaomi_mir3g-v2.dts 好像被改成了 mt7621_xiaomi_mi-router-4a-3g-v2.dtsi  测试一下
## 1.修改 mt7621_xiaomi_mir3g-v2.dts
export shanchu1=$(grep  -a -n -e '&spi0 {' target/linux/ramips/dts/mt7621_xiaomi_mi-router-4a-3g-v2.dtsi|cut -d ":" -f 1)
export shanchu2=$(grep  -a -n -e '&pcie {' target/linux/ramips/dts/mt7621_xiaomi_mi-router-4a-3g-v2.dtsi|cut -d ":" -f 1)
export shanchu2=$(expr $shanchu2 - 1)
export shanchu2=$(echo $shanchu2"d")
sed -i $shanchu1,$shanchu2 target/linux/ramips/dts/mt7621_xiaomi_mi-router-4a-3g-v2.dtsi
grep  -Pzo '&spi0[\s\S]*};[\s]*};[\s]*};[\s]*};' target/linux/ramips/dts/mt7621_youhua_wr1200js.dts > youhua.txt
echo "" >> youhua.txt
echo "" >> youhua.txt
export shanchu1=$(expr $shanchu1 - 1)
export shanchu1=$(echo $shanchu1"r")
sed -i "$shanchu1 youhua.txt" target/linux/ramips/dts/mt7621_xiaomi_mi-router-4a-3g-v2.dtsi
rm -rf youhua.txt
## 2.修改mt7621.mk
export imsize1=$(grep  -a -n -e 'define Device/xiaomi_mir3g-v2' target/linux/ramips/image/mt7621.mk|cut -d ":" -f 1)
export imsize1=$(expr $imsize1 + 2)
export imsize1=$(echo $imsize1"s")
sed -i "$imsize1/IMAGE_SIZE := .*/IMAGE_SIZE := 16064k/" target/linux/ramips/image/mt7621.mk

# diy
cd package/openwrt-packages
rm -rf luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git
