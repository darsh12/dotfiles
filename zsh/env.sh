#!/bin/bash

set -o vi

# Specify default editor. Possible values: vim, nano, ed etc.
export EDITOR=vim
export TERM=screen-256color
export POWERLINE_LOCATION=$(pip3 show powerline-status | grep Location | awk -F ': ' '{print $2}')



# Update function
function dotbot() {

  if [[ -d ~/dotfiles ]]; then
    cd ~/dotfiles
  elif [[ -d ~/.dotfiles ]]; then
    cd ~/.dotfiles
  fi

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
if [ -f ~/.aliases ]; then
	source ~/.aliases
fi

export FZF_DEFAULT_OPTS="--no-mouse --height=50% -1 --reverse --multi --inline-info  --preview=' [[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f2:toggle-preview,ctrl-y:execute-silent(echo {} | pbcopy)+abort'"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
