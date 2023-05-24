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
sed -i '$a src-git helloworld https://github.com/fw876/helloworld.git' feeds.conf.default
sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default

# 21版本的固件安装 iStore 需要依赖 luci-compat
sed -i '$a src-git istore https://github.com/linkease/istore;main' feeds.conf.default
# compat for 21.02
sed -i '$a src-git compat https://github.com/jjm2473/openwrt-compat.git;21.02' feeds.conf.default

# 添加netspeedtest
git clone https://github.com/sirpdboy/netspeedtest.git package/netspeedtest