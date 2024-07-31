#!/bin/bash
#
echo "Auto Run:"
# 修改openwrt登陆地址,把下面的192.168.31.1修改成你想要的就可以了
# sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把YOU-R4A修改你喜欢的就行（不能纯数字或者使用中文）
sed -i '/uci commit system/i\uci set system.@system[0].hostname='OpenWRT'' package/lean/default-settings/files/zzz-default-settings

# x86 型号只显示 CPU 型号
sed -i 's/${g}.*/${a}${b}${c}${d}${e}${f}${hydrid}/g' package/lean/autocore/files/x86/autocore

# 修改本地时间格式
sed -i 's/os.date()/os.date("%a %Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/*/index.htm

# 修改默认wan口为eth0
sed -i '11s/ucidef_set_interface_lan/ucidef_set_interface_wan/g' package/base-files/files/etc/board.d/99-default_network
sed -i '12s/ucidef_set_interface_wan/ucidef_set_interface_lan/g' package/base-files/files/etc/board.d/99-default_network

echo "remove packages"
# 替换的包 

# luci-app-serverchan
rm -rf feeds/luci/applications/luci-app-serverchan
git clone --depth=1 -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush package/luci-app-serverchan

# mosdns
rm -rf feeds/packages/net/mosdns
rm -rf feeds/luci/applications/luci-app-mosdns
git clone https://github.com/sbwml/luci-app-mosdns.git
mv luci-app-mosdns/luci-app-mosdns ./package/luci-app-mosdns
mv luci-app-mosdns/mosdns ./package/mosdns
rm -rf luci-app-mosdns

# luci-app-adguardhome
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome

# luci-app-netdata
rm -rf feeds/luci/applications/luci-app-netdata
git clone --depth=1 https://github.com/Jason6111/luci-app-netdata package/luci-app-netdata

git clone --depth=1 https://github.com/ilxp/luci-app-ikoolproxy package/luci-app-ikoolproxy
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
git clone --depth=1 https://github.com/destan19/OpenAppFilter package/OpenAppFilter

# msd_lite
rm -rf feeds/packages/net/msd_lite
git clone --depth=1 https://github.com/ximiTech/luci-app-msd_lite package/luci-app-msd_lite
git clone --depth=1 https://github.com/ximiTech/msd_lite package/msd_lite

# luci-app-eqosplus
git clone https://github.com/sirpdboy/luci-app-eqosplus package/luci-app-eqosplus

# ddns-go
git clone https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go

# 添加netspeedtest
git clone --depth=1 https://github.com/sirpdboy/netspeedtest.git package/netspeedtest

# 添加advancedplus
git clone https://github.com/sirpdboy/luci-app-advancedplus.git package/luci-app-advancedplus


# openclash
git clone https://github.com/chenlunTian/luci-app-openclash.git package/luci-app-openclash

# 设置root密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
#sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings
# 设置root密码为Tian1234567
# 命令行生成密码字符串：perl -e 'print crypt("admin",q($1$wEehtjxj)),"\n"'
# admin为密码明文   q($加密方式$加密盐‘就是一长串字符’)
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF./$1$V4UetPzk$.rFSRjK6PwDBOOQ6vpXIw./g' ./package/lean/default-settings/files/zzz-default-settings

# 修改插件名字（修改名字后不知道会不会对插件功能有影响，自己多测试）
#sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' package/lean/luci-app-turboacc/po/zh-cn/turboacc.po

echo "run scripts update && install"

./scripts/feeds update -a
./scripts/feeds install -a
