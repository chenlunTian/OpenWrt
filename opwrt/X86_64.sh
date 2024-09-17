#!/bin/bash
#
echo "Auto Run:"
# 修改openwrt登陆地址,把下面的192.168.31.1修改成你想要的就可以了
# sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# 修改ntp服务器地址
sed -i '323s/0/1/g' package/base-files/files/bin/config_generate
sed -i '324s/0.openwrt.pool.ntp.org/ntp1.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i '325s/1.openwrt.pool.ntp.org/ntp.tencent.com/g' package/base-files/files/bin/config_generate
sed -i '326s/2.openwrt.pool.ntp.org/ntp.ntsc.ac.cn/g' package/base-files/files/bin/config_generate
sed -i '327s/3.openwrt.pool.ntp.org/time.ustc.edu.cn/g' package/base-files/files/bin/config_generate

# 修改时区为 CST-8 此项要是再ntp服务器之前则ntp对应行数加1
sed -i '315s/UTC/CST-8/g' package/base-files/files/bin/config_generate
sed -i "315a\		set system.@system[-1].zonename='Asia/Shanghai'" package/base-files/files/bin/config_generate

# 修改默认wan口为eth0,并增加eth2为lan口
sed -i '11s/ucidef_set_interface_lan/ucidef_set_interface_wan/g' package/base-files/files/etc/board.d/99-default_network
sed -i '12s/ucidef_set_interface_wan/ucidef_set_interface_lan/g' package/base-files/files/etc/board.d/99-default_network
sed -i "12a\[ -d /sys/class/net/eth2 ] && ucidef_set_interface_lan 'eth2'" package/base-files/files/etc/board.d/99-default_network

# 设置root密码为Tian1234567
# 命令行生成密码字符串：perl -e 'print crypt("admin",q($1$wEehtjxj)),"\n"'
# admin为密码明文   q($加密方式$加密盐‘就是一长串字符’) $1$wEehtjxj$7FrtVwl75w.g2zF0c0jKk/
sed -i 's/root:::0:99999:7:::/root:$1$wEehtjxj$7FrtVwl75w.g2zF0c0jKk/:0:99999:7:::/g' package/base-files/files/etc/shadow

echo "remove packages"
# 替换的包 

# luci-app-netdata
rm -rf feeds/luci/applications/luci-app-netdata
git clone --depth=1 https://github.com/Jason6111/luci-app-netdata package/luci-app-netdata

git clone --depth=1 https://github.com/destan19/OpenAppFilter package/OpenAppFilter

# luci-app-eqosplus
git clone https://github.com/sirpdboy/luci-app-eqosplus package/luci-app-eqosplus

# 添加netspeedtest
git clone --depth=1 https://github.com/sirpdboy/netspeedtest.git package/netspeedtest

# 添加advancedplus
git clone https://github.com/sirpdboy/luci-app-advancedplus.git package/luci-app-advancedplus

# 添加turboacc
curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh

# 删除老版本watchcat
rm -rf feeds/packages/utils/watchcat
git clone https://github.com/chenlunTian/watchcat.git feeds/packages/utils/watchcat
git clone https://github.com/MilesPoupart/luci-app-watchcat-plus.git package/luci-app-watchcat-plus

echo "run scripts update && install"

./scripts/feeds update -a
./scripts/feeds install -a
