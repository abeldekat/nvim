# _all(){
#   nvim +LoadAllCollection +PackerClean +PackerInstall +PackerCompile
# }
# _core(){
#   nvim +LoadCoreCollection +PackerClean +PackerInstall +PackerCompile
# }

# -c "qall!"

_go(){
  echo "$1 clean"
  vim --headless +'autocmd User PackerComplete quitall' +$1 +PackerClean +PackerCompile

  echo "$1 install"
  vim --headless +'autocmd User PackerComplete quitall' +$1 +PackerInstall +PackerCompile
}

_core_headless(){
  echo "headless core"
  _go "LoadCoreCollection"
  echo "done"
}

_core_and_colors_headless(){
  echo "headless core and colors"
  _go "LoadCoreCollectionAndColors"
  echo "done"
}

_nth_headless(){
  echo "headless nice to have"
  _go "LoadNiceToHaveCollection"
  echo "done"
}

_nth_and_colors_headless(){
  echo "headless nice to have and colors"
  _go "LoadNiceToHaveCollectionAndColors"
  echo "done"
}

_colors_headless(){
  echo "headless nice to have"
  _go "LoadColorCollection"
  echo "done"
}

_all_headless(){
  echo "headless all"
  _go "LoadAllCollection"
  echo "done"
}

#.../nvim/scratch on  master [!?] ❯ v --headless +'autocmd User PackerComplete quitall' +LoadAllCollection

# Example complete install:
# .../nvim/scratch on  master [!] took 3s ❯ ./reset_nvim.sh -n && ./start_nvim_with_packer.sh -a
while getopts "hdDsSca" o; do case "${o}" in
	h) printf 'a load all, d load core, D without colors, s nth, S without colors ' && exit ;;
	d) _core_and_colors_headless;;
	D) _core_headless;;
	s) _nth_and_colors_headless;;
	S) _nth_headless;;
	c) _colors_headless;;
	a) _all_headless;;
	*) printf "Invalid option: -%s\\n" "$OPTARG" && exit ;;
	esac
done


