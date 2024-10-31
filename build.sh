#!/usr/bin/env bash

set -xe

. /etc/os-release

case "$NAME" in
    "Fedora")
        dnf install -y clang make git python3-devel lua-devel lua ncurses-devel
        ;;
    "Rocky Linux")
        dnf install -y epel-release
        # lua-develだけはdevelリポジトリにある。
        dnf install --enablerepo=devel -y clang make git python3-devel lua-devel lua ncurses-devel
        ;;
    "Ubuntu")
        # 仕組みは不明だが、
        # - liblua5.4-devを入れると、/usr/include/lua5.4/以下にluaのヘッダが入る
        # - lua5.4を入れると、./configureが/usr/include/lua5.4をインクルードパスに含める
        # それでliblua5.4-devとlua5.4の両方が必要。
        apt-get update
        apt-get install -y clang make git libpython3.10-dev liblua5.4-dev lua5.4
        ;;
    *)
        echo "Unsupported OS"
        exit 1
        ;;
esac

mkdir -p /usr/local/vim
cd /usr/local/vim
rm -rf src
git clone --depth 1 https://github.com/vim/vim.git src
cd src/src

./configure \
--prefix=/usr/local/vim \
--enable-python3interp=yes \
--enable-luainterp=yes

make -j2
make install
