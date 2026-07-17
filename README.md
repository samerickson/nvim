# Sam Erickson's Neovim Configuration

## Dependencies

- `win32yank`: better clipboard management in WSL [link](https://github.com/equalsraf/win32yank)

### Language servers

I have switched to manually installing language servers. Here are my notes on how I installed each of them

#### Servers Available Through NPM

```bash
npm i -g @vtsls/language-server bash-language-server @vue/language-server vscode-langservers-extracted
```


#### Lua_ls

I install this by downloading the latest release from: <https://github.com/LuaLS/lua-language-server/releases> and unpacking to `/opt/lua-language-server-3-18-2` for instance.

Then sym linking it to my path

```bash
ln -s /opt/lua-language-server-3-18-2/bin/lua-language-server ~/.local/bin/lua-language-server
```

### Formatters

#### Stylua

```bash
cargo install stylua
cargo install stylua --features lua52
cargo install stylua --features lua53
cargo install stylua --features lua54
cargo install stylua --features luajit
cargo install stylua --features luau
```

### Linters

```bash
npm install -g markdownlint-cli
```
