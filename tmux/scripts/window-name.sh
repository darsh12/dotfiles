#!/usr/bin/env bash
# Name a tmux window: ssh:<host> for ssh, program name for other programs,
# folder name when sitting at a shell prompt.
# Usage: window-name.sh <pane_tty> <pane_current_command> <pane_current_path>
tty="${1#/dev/}"; cmd="$2"; dir="$3"

# Foreground process args on the pane's tty (stat contains '+')
fg_args=$(ps -t "$tty" -o stat=,args= 2>/dev/null | awk '$1 ~ /\+/ { $1=""; sub(/^ /,""); print; exit }')
fg_cmd=${fg_args%% *}
fg_cmd=${fg_cmd##*/}

if [ "$fg_cmd" = ssh ]; then
  # Skip ssh options (and their values) to find the destination
  set -- ${fg_args#* }
  while [ $# -gt 0 ]; do
    case "$1" in
      -[bcDEeFIiJLlmOopQRSWw]) shift 2 ;;
      -*) shift ;;
      *) host="${1##*@}"; break ;;
    esac
  done
  echo "ssh:${host:-$cmd}"
  exit
fi

case "$cmd" in
  zsh|bash|fish|sh|dash|-zsh|-bash)
    if [ "$dir" = "$HOME" ]; then echo "~"; else echo "${dir##*/}"; fi ;;
  *) echo "$cmd" ;;
esac
