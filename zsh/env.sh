#!/bin/bash

set -o vi

# Specify default editor. Possible values: vim, nano, ed etc.
export EDITOR=vim


# File search functions
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

export TERM=screen-256color

#Used to store personal env variables
if [ -f ~/.env_personal ]; then
	source ~/.env_personal
fi

# Source aliases
Alias=$HOME/.aliases
if [ -f $Alias ]; then
	source $Alias
fi

