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
sed -i '$a src-git istore https://github.com/linkease/istore;main' feeds.conf.default
sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default

sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '$a src-git small8 https://github.com/kenzok8/small-package' feeds.conf.default

