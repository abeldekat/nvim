#!/usr/bin/env bash

_PATH="$HOME/.config/nvim"
_PA="$_PATH/lua/pa"
_CACHE="$HOME/.cache/nvim"
_SHARED="$HOME/.local/share/nvim"
_PACKER="$_SHARED/site/pack/packer"
_PACKER_BACKUP="$HOME/plugins/packersync"
_SNAPSHOT_BACKUP="$_PACKER_BACKUP/snapshots"

_PACKER_COMPILED="$_PATH/plugin/packer_compiled.lua"
_NO_PACKER_COMPILED="$_PATH/after/plugin/zz_self_compiled_from_lazy.lua"

_clean_packer() {
	if [[ -d "$_PACKER/start" ]]; then
		echo "Removing packer start"
		\rm -rf "$_PACKER/start"
		mkdir "$_PACKER/start"
	fi

	if [[ -d "$_PACKER/opt" ]]; then
		echo "Removing packer opt"
		\rm -rf "$_PACKER/opt"
		mkdir "$_PACKER/opt"
	fi
}

_clean_vim() {
	echo "clean neovim selectively"
	\rm -rf "$_CACHE/packer.nvim"
	\rm -rf "$_CACHE/undo"
	find "$_CACHE" -type f -name "*log" | xargs rm -rf
	\rm -rf "$_CACHE/luacache_chunks"
	\rm -rf "$_CACHE/luacache_modpaths"

	# rm -rf "$_SHARED/lsp_servers"
	# rm -rf "$_SHARED/project_nvim"
	# rm -rf "$_SHARED/harpoon.json"
	# rm -rf "$_SHARED/rplugin.vim"
	# rm -rf "$_SHARED/file_frecency.sqlite3"
	# rm -rf "$_SHARED/neoclip.sqlite3"

	\rm -rf "$_SHARED/shada"
	\rm -rf "$_PACKER_COMPILED"
	\rm -rf "$_NO_PACKER_COMPILED"

	echo "done"
}

_clean_everything() {
	echo "clean all neovim"
	echo "Removing contents of nvim local"
	\rm -rf "$_SHARED"
	mkdir -p "$_SHARED/site/pack/packer"
	echo "Removing contents of cache"
	\rm -rf "$_CACHE"
	mkdir "$_CACHE"

	echo "Removing compiled..."
	\rm -rf "$_PACKER_COMPILED"
	\rm -rf "$_NO_PACKER_COMPILED"

	echo "done"
}

# rsync packer dir towards packer dir in backup
_backup() {
	echo "backup packer"
	rsync -a "$_PACKER" "$_PACKER_BACKUP"
	rsync -a "$_CACHE/packer.nvim/" "$_SNAPSHOT_BACKUP"
	echo "done"
}

# rsync backup packer dir towards site packer dir
_restore() {
	echo "restore packer"
	rsync -a "$_PACKER_BACKUP/packer" "$_PACKER/.."
	echo "done"
}

# clean selectively and restore packer packages
# Manual steps after this operation:
# PackerInstall, PackerClean and PackerCompile. Restart vim
_new_starting_position() {
	echo "new starting position clean and restore"
	_clean_packer
	_clean_vim
	_restore
	echo "done"
}

_new_starting_position_no_lazy_load() {
	echo "new not lazy starting position clean and restore"
	_clean_packer
	_clean_vim
	_restore

	echo "rsync all of packer opt to start"
	rsync -a "$_PACKER/opt/" "$_PACKER/start"
	echo "empty packer opt"
	\rm -rf "$_PACKER/opt"
	mkdir "$_PACKER/opt"

	echo "creating self_compiled.lua"
	cd "$_PA" || exit
	for f in "./telescope.lua" "./dap.lua" "nth_collection.lua" "in_test_collection.lua"; do
		# only find the require <aconfig> inside a function by filtering out lines containing
		# commented requires and lines with requires and a comma
		grep 'require "' "$f" | sed '/--/d' | sed '/,/d' >>"$_NO_PACKER_COMPILED"
	done
	cd - || exit

	echo "done"
}

while getopts "hbcCrnNp" o; do
	case "$o" in
	h) printf 'n new starting position, N not lazy, b backup, c clean vim, C clean all, r restore, p clean packer ...' && exit ;;
	b) _backup ;;
	c) _clean_vim ;;
	C) _clean_everything ;;
	r) _restore ;;
	n) _new_starting_position ;;
	N) _new_starting_position_no_lazy_load ;;
	p) _clean_packer ;;
	# f) _a_file "$OPTARG";;
	*) printf "Invalid option: -%s\\n" "$OPTARG" && exit ;;
	esac
done
