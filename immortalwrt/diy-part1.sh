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

echo "开始 DIY1 配置……"
echo "========================="

# Uncomment a feed source
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

# rm -rf target/linux/ramips
# svn export https://github.com/padavanonly/immortalwrt/trunk/target/linux/ramips target/linux/ramips

# openssl Enable QUIC and KTLS support
curl -s https://github.com/openwrt/openwrt/commit/362aea4649485ca7c31ce42c371d5051e7dead4d.patch | patch -p1

# 修改系统版本（界面显示）
VERSION=${GITHUB_WORKSPACE}/immortalwrt/version
VERSION_TEXT=$(head -n 1 ${VERSION} | tr -d ' \r\n')
if [ -n "$VERSION_TEXT" ]; then
	sed -i "/^VERSION_NUMBER:=.*SNAPSHOT/s/SNAPSHOT/${VERSION_TEXT}/" include/version.mk
fi


echo "========================="
echo " DIY1 配置完成……"
