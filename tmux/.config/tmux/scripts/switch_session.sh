#!/usr/bin/env bash
# Switch to the Nth session sorted by creation time, excluding opencode sessions
N=$1
target=$(tmux list-sessions -F '#{session_created} #{session_name}' | sort -rn | awk '{print $2}' | grep -v '^opencode' | awk "NR==$N")
[ -n "$target" ] && tmux switch-client -t "$target"
