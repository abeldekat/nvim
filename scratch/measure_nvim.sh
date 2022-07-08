#!/usr/bin/env bash

# https://github.com/rhysd/vim-startuptime/releases

# v.1.2.0, downloaded to .local/bin
# Add -verbose flag to output the progress of measurements to stderr
# Add support for LunarVim (thanks @runar-rkmedia, #1)
# Build binaries with the latest Go compiler 1.18.0

# vim-startuptime_1.2.0_linux_amd64.tar.gz
# If you want to give some options to underlying vim command executions, please specify them after -- argument in command line as follows:
# $ vim-startuptime -- --cmd DoSomeCommand

CYCLES=30

function _goprogram(){
  vim-startuptime -vimpath nvim -warmup 5 -verbose -count $CYCLES ../init.lua > vimreport.out
  cat vimreport.out | head -6
}

function _ownscript(){
  rm -rf ./reports
  mkdir ./reports

  for i in {1..5}
  do
    nvim --headless -c "qall!" ../init.lua 1&>/dev/null
  done

  for (( c=1; c<=$CYCLES; c++ ))
  do
    nvim --headless --startuptime ./reports/vimreport$c.out -c "qall!" ../init.lua 1&>/dev/null
  done

  for file in ./reports/*.out
  do
    cat $file | tail -1 | cut -d. -f1 >> ./reports/totals.txt
  done

  TOTAL=$(cat ./reports/totals.txt | xargs | sed -e 's/ /+/g' | bc)
  RESULT=$(echo "$TOTAL/$CYCLES" | bc)

  echo "cycles: $CYCLES"
  echo "calculated total: $TOTAL"
  echo "result: $RESULT"
}

while getopts "hgo" o; do case "${o}" in
	h) printf 'g is go program, o is own script' && exit ;;
	g) _goprogram;;
	o) _ownscript;;
	*) printf "Invalid option: -%s\\n" "$OPTARG" && exit ;;
	esac
done
