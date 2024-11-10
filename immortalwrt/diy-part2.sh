#!/bin/bash
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 默认IP由1.1修改为0.1
sed -i 's/192.168.1.1/192.168.5.8/g' package/base-files/files/bin/config_generate

# Add luci-app
# rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd-alt,miniupnpd-iptables,wireless-regdb}
# rm -rf feeds/other/{luci-app-adguardhome,luci-app-dockerman}
# rm -rf feeds/lienol/luci-app-fileassistant && rm -rf feeds/packages/net/{adguardhome,smartdns}
# rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box,pdnsd-alt,brook,chinadns-ng,dns2socks,dns2tcp,gn,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan,trojan-go,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,gn}
# rm -rf package/passwall-packages/{chinadns-ng,naiveproxy,shadowsocks-rust,v2ray-geodata}
# rm -rf feeds/luci/themes/luci-theme-argon
# git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
# merge_package main https://github.com/sbwml/luci-theme-argon feeds/luci/themes luci-theme-argon

# 最大连接数修改为554288
# sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=554288' package/base-files/files/etc/sysctl.conf

# 修复上移下移按钮翻译
# sed -i 's/<%:Up%>/<%:Move up%>/g' feeds/luci/modules/luci-compat/luasrc/view/cbi/tblsection.htm
# sed -i 's/<%:Down%>/<%:Move down%>/g' feeds/luci/modules/luci-compat/luasrc/view/cbi/tblsection.htm

# 修复procps-ng-top导致首页cpu使用率无法获取
# sed -i 's#top -n1#\/bin\/busybox top -n1#g' feeds/luci/modules/luci-base/root/usr/share/rpcd/ucode/luci

# unzip
# rm -rf feeds/packages/utils/unzip
# git clone https://github.com/sbwml/feeds_packages_utils_unzip feeds/packages/utils/unzip

# golang 1.23
# rm -rf feeds/packages/lang/golang
# git clone --depth=1 https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang

# ppp - 2.5.1
# rm -rf package/network/services/ppp
# git clone https://github.com/sbwml/package_network_services_ppp package/network/services/ppp

# 精简 UPnP 菜单名称
# sed -i 's#\"title\": \"UPnP IGD \& PCP/NAT-PMP\"#\"title\": \"UPnP\"#g' feeds/luci/applications/luci-app-upnp/root/usr/share/luci/menu.d/luci-app-upnp.json

# 修复编译时提示 freeswitch 缺少 libpcre 依赖
# sed -i 's/+libpcre \\$/+libpcre2 \\/g' package/feeds/telephony/freeswitch/Makefile

# 修正部分从第三方仓库拉取的软件 Makefile 路径问题
# find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' {}
# find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/lang\/golang\/golang-package.mk/$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang-package.mk/g' {}
# find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHREPO/PKG_SOURCE_URL:=https:\/\/github.com/g' {}
# find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload.github.com/g' {}

# ./scripts/feeds update -a
# ./scripts/feeds install -a
