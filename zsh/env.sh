#!/bin/bash

set -o vi

# Add commonly used folders to $PATH
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

export PATH=$PATH:/Library/TeX/texbin:/usr/local/MacGPG2/bin:/usr/local/share/dotnet:~/.dotnet/tools:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/Applications/Wireshark.app/Contents/MacOS:/Applications/Xamarin\ Workbooks.app/Contents/SharedSupport/path-bin

export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

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

if [ -f ~/.aliases ]; then
	source ~/.aliases
fi
