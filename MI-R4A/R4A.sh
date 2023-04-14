#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改openwrt登陆地址,把下面的192.168.31.1修改成你想要的就可以了
# sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把YOU-R4A修改你喜欢的就行（不能纯数字或者使用中文）
sed -i '/uci commit system/i\uci set system.@system[0].hostname='PandoraBox'' package/lean/default-settings/files/zzz-default-settings

# 版本号里显示一个自己的名字（ababwnq build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
sed -i 's/OpenWrt /编译时间 $(TZ=UTC-8 date "+%Y.%m.%d") @ 沉沦 /g' package/lean/default-settings/files/zzz-default-settings

#删除原默认主题
rm -rf package/lean/luci-theme-argon
rm -rf package/lean/luci-theme-bootstrap
rm -rf package/lean/luci-theme-material
rm -rf package/lean/luci-theme-netgear
rm -rf package/kenzo/luci-theme-ifit

#下载主题luci-theme-argon
git clone https://github.com/chenlunTian/luci-theme-argon_armygreen package/lean/luci-theme-argon_armygreen

# 修改luci-theme-argon_armygreen主题渐变色，16进制RGB
#登录页面背景颜色 透明值
sed -i 's/#f7fafc/rgba(134,176,197, .5)/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css

#渐变色开始
sed -i 's/#f9ffff/#80ABC3/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css
#渐变色结束b8 57
sed -i 's/#7fffffb8/#5C859B/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css
sed -i 's/#9effff57/#9FC4D5/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css
#加载背景
sed -i 's/#5e72e4/#407994/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css

#取消原主题luci-theme-bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

# 修改argon_armygreen为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
sed -i 's/luci-theme-bootstrap/luci-theme-argon_armygreen/g' feeds/luci/collections/luci/Makefile

# 设置root密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
#sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings
# 设置root密码为Tian1234567
# 命令行生成密码字符串：perl -e 'print crypt("admin",q($1$wEehtjxj)),"\n"'
# admin为密码明文   q($加密方式$加密盐‘就是一长串字符’)
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF./$1$V4UetPzk$.rFSRjK6PwDBOOQ6vpXIw./g' ./package/lean/default-settings/files/zzz-default-settings

# 修改插件名字（修改名字后不知道会不会对插件功能有影响，自己多测试）
#sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' package/lean/luci-app-turboacc/po/zh-cn/turboacc.po

# 修改wifi标准为中国 CN、JP、HK均可开启13信道，默认的US只有1-12信道
sed -i 's/country=US/country=CN/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改默认wifi名称ssid为PandoraBox
sed -i 's/ssid=OpenWrt/ssid=PandoraBox/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改默认wifi密码为psk2+ccmp类型key为Tian1234567
sed -i 's/encryption=none/encryption=psk2+ccmp/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#使用sed 在第四行后添加新字
sed -i '/set wireless.default_radio${devidx}.encryption=psk2+ccmp/a\set wireless.default_radio${devidx}.key=Tian1234567' package/kernel/mac80211/files/lib/wifi/mac80211.sh
