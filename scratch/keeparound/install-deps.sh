#!/usr/bin/env bash

# Taken from lunarvim, not uptodate...
set -eo pipefail

declare -a __npm_deps=(
  "neovim"
  "tree-sitter-cli"
)

declare -a __pip_deps=(
  "pynvim"
)

function msg() {
  local text="$1"
  local div_width="80"
  printf "%${div_width}s\n" ' ' | tr ' ' -
  printf "%s\n" "$text"
}

function print_missing_dep_msg() {
  if [ "$#" -eq 1 ]; then
    echo "[ERROR]: Unable to find dependency [$1]"
    # echo "Please install it first and re-run the installer. Try: $RECOMMEND_INSTALL $1"
  else
    local cmds
    cmds=$(for i in "$@"; do echo "$RECOMMEND_INSTALL $i"; done)
    printf "[ERROR]: Unable to find dependencies [%s]" "$@"
    # printf "Please install any one of the dependencies and re-run the installer. Try: \n%s\n" "$cmds"
  fi
}

function __install_nodejs_deps_npm() {
  echo "Installing node modules with npm.."
  for dep in "${__npm_deps[@]}"; do
    if ! npm ls -g "$dep" &>/dev/null; then
      printf "installing %s .." "$dep"
      npm install -g "$dep"
    fi
  done
  echo "All NodeJS dependencies are successfully installed"
}

function install_nodejs_deps() {
  local -a pkg_managers=("yarn" "npm")
  for pkg_manager in "${pkg_managers[@]}"; do
    if command -v "$pkg_manager" &>/dev/null; then
      eval "__install_nodejs_deps_$pkg_manager"
      return
    fi
  done
  print_missing_dep_msg "${pkg_managers[@]}"
  exit 1
}

function install_python_deps() {
  echo "Verifying that pip is available.."
  if ! python3 -m ensurepip &>/dev/null; then
    if ! python3 -m pip --version &>/dev/null; then
      print_missing_dep_msg "pip"
      exit 1
    fi
  fi
  echo "Installing with pip.."
  for dep in "${__pip_deps[@]}"; do
    python3 -m pip install --user "$dep"
  done
  echo "All Python dependencies are successfully installed"
}

function __attempt_to_install_with_cargo() {
  if command -v cargo &>/dev/null; then
    echo "Installing missing Rust dependency with cargo"
    cargo install "$1"
  else
    echo "[WARN]: Unable to find cargo. Make sure to install it to avoid any problems"
    exit 1
  fi
}

# we try to install the missing one with cargo even though it's unlikely to be found
function install_rust_deps() {
  local -a deps=("fd::fd-find" "rg::ripgrep")
  for dep in "${deps[@]}"; do
    if ! command -v "${dep%%::*}" &>/dev/null; then
      __attempt_to_install_with_cargo "${dep##*::}"
    fi
  done
  echo "All Rust dependencies are successfully installed"
}

function main() {
  msg "Would you like to install NodeJS dependencies?"
  read -p "[y]es or [n]o (default: no) : " -r answer
  [ "$answer" != "${answer#[Yy]}" ] && install_nodejs_deps

  msg "Would you like to install Python dependencies?"
  read -p "[y]es or [n]o (default: no) : " -r answer
  [ "$answer" != "${answer#[Yy]}" ] && install_python_deps

  msg "Would you like to install Rust dependencies?"
  read -p "[y]es or [n]o (default: no) : " -r answer
  [ "$answer" != "${answer#[Yy]}" ] && install_rust_deps
}

main "$@"
