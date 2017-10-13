#!/bin/sh

set -ex

echo "Install Plugins..."
vim -c PluginInstall -c qall

echo "Compile YCM..."
./build/user_env/vim/YouCompleteMe/install.py --clang-completer

echo "Done"
