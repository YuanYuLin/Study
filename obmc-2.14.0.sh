#!/bin/bash

# 設定 OpenBMC Repository URL 和 Tag
OPENBMC_REPO="https://github.com/openbmc/openbmc.git"
TAG="2.14.0"
CLONE_DIR="openbmc"

# 如果已經存在該目錄，先詢問是否刪除
if [ -d "$CLONE_DIR" ]; then
    echo "目錄 $CLONE_DIR 已存在"
        exit 1
fi

echo "Cloning OpenBMC repository..."
git clone "$OPENBMC_REPO" "$CLONE_DIR" || { echo "Clone 失敗！"; exit 1; }

cd "$CLONE_DIR" || exit 1

echo "Checking out tag $TAG..."
git checkout tags/"$TAG" -b "$TAG-branch" || { echo "切換到 $TAG 失敗！"; exit 1; }

eobmc-2.14.0.shcho "OpenBMC 版本 $TAG 準備完成！"

