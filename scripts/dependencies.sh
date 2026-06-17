#!/bin/sh

# This script provides no error checking and assumes package managers are already installed

npm i -g @vtsls/language-server
npm i -g bash-language-server
npm i -g @vue/language-server
npm i -g vscode-langservers-extracted

# luarocks install lua_ls
# go install golang.org/x/tools/gopls@latest
