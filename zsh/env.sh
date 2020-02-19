#!/bin/bash

set -o vi

# Specify default editor. Possible values: vim, nano, ed etc.
export EDITOR=vim
export TERM=screen-256color
export POWERLINE_LOCATION=$(pip3 show powerline-status | grep Location | awk -F ': ' '{print $2}')


# File search functions
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

# Update function
function dotbot() {
    cd ~/dotfiles
    git pull -q
    if [[ lsb_release -eq "Darwin" ]]; then
      ./install-profile mac
    elif [[ lsb_release -eq "Linux" ]]; then
        ./install-profile linux
    else
      echo "Invalid OS"
      exit 1
    fi
}


#Used to store personal env variables
if [ -f ~/.env_personal ]; then
	source ~/.env_personal
fi

# Source aliases
Alias=$HOME/.aliases
if [ -f $Alias ]; then
	source $Alias
fi

