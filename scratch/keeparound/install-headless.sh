#!/usr/bin/env bash
_PATH="$HOME/.config/nvim"
_INIT="$_PATH/init.lua"
_PLUGIN_LOADER="$_PATH/lua/ak/plugin-loader.lua"
_THEME="$_PATH/after/plugin/colorscheme.lua"

_install_headless(){
  echo "Disable impatient, speed, themes and user plugins..."
  sed -i 's/require "impatient"/-- require "impatient"/' "$_INIT"
  # sed -i 's/require "ak.disable_builtin"/-- require "ak.disable_builtin"/' "$_INIT"

  sed -i "s/local color.*$/local color = 'onedarker'/" $_THEME
  sed -i 's/plugins.user/-- plugins.user/' "$_PLUGIN_LOADER"
  sed -i 's/plugins.colors/-- plugins.colors/' "$_PLUGIN_LOADER"

  echo "Packersync and quitall..."
  nvim --headless -c 'lua require("ak.plugin-loader")' -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

  echo "Enable impatient, speed, themes and user plugins..."
  sed -i 's/-- require "impatient"/require "impatient"/' "$_INIT"
  # sed -i 's/-- require "ak.disable_builtin"/require "ak.disable_builtin"/' "$_INIT"
  sed -i 's/-- plugins.user/plugins.user/' "$_PLUGIN_LOADER"
  sed -i 's/-- plugins.colors/plugins.colors/' "$_PLUGIN_LOADER"

  echo "Git assume unchanged active-theme.lua..."
  git update-index --assume-unchanged $_THEME

  echo "Done installing core...Start nvim, run PackerSync..."
}

_clean(){
  echo "Removing nvim local"
  rm -rf ~/.local/share/nvim
  echo "Removing cache"
  rm -rf ~/.cache/nvim
  echo "Removing packer compiled..."
  [ -d "$_PATH/plugin" ] && rm -rf "$_PATH/plugin/packer_compiled.lua"
}

#_clean
# _install_headless
