#!/bin/bash
export LC_ALL=C
export THEOS=~/theos_roothide
export THEOS_DEVICE_IP=192.168.31.159
export THEOS_DEVICE_PORT=54323
export ARCHS="arm64"

#取绝对路径
tweakPath=$(cd "$(dirname "$0")";pwd)
buildPath="$(dirname "$tweakPath")/__build_roothide/$(basename "$tweakPath")"
echo "tweakPath: $tweakPath"
echo "buildPath: $buildPath"
cd $tweakPath


if [ -d "$buildPath" ]; then
    rm -rf "$buildPath" || { echo "清理 buildPath 失败: $buildPath"; exit 1; }
fi
mkdir -p "$buildPath" || { echo "创建 buildPath 失败: $buildPath"; exit 1; }
cp -a . "$buildPath"/ || { echo "复制源文件到 buildPath 失败: $buildPath"; exit 1; }
cd "$buildPath" || { echo "切换到 buildPath 失败: $buildPath"; exit 1; }

# 如果还是原来的路径就退出
currentPath=$(pwd)
echo "currentPath: $currentPath"
if [ "$currentPath" == "$tweakPath" ]
then
    echo "当前路径未改变，退出脚本以防止覆盖原文件"
    exit 1
fi



find . -type f -exec sed -i '' -e 's/#import "rootless.h"/#include <roothide.h>/g; s/#import <rootless.h>/#include <roothide.h>/g; s/ROOT_PATH_NS/jbroot/g; s/ROOT_PATH/jbroot/g' {} +



if [ $1 -eq "0" ]
then
    export package FINALPACKAGE=1
	export THEOS_PACKAGE_SCHEME=roothide
    export SILEO_PLATFORM=iphoneos-arm64e
    export DEVELOPER_DIR="/Applications/Xcode-14.3.0.app/Contents/Developer"

	make package
	cp -f ./packages/*.deb ~/Documents/GitHub/myTweaks/roothide/
	exit
fi


if [ $1 -eq "1" ]
then
	export THEOS_PACKAGE_SCHEME=roothide
	make do 
	exit
fi


if [ $1 -eq "2" ]
then
	export package FINALPACKAGE=1
    export DEVELOPER_DIR="/Applications/Xcode-14.3.0.app/Contents/Developer"

	export THEOS_PACKAGE_SCHEME=roothide
    make do -j$(sysctl -n hw.physicalcpu)

	export THEOS_PACKAGE_SCHEME=rootless
    make package -j$(sysctl -n hw.physicalcpu)

	# cp -f ./packages/*.deb $tweakPath
	mv ./packages/*.deb ~/Documents/GitHub/myTweaks/rootless/
    exit
fi