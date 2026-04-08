#
# ~/.bashrc
#

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

export EDITOR="nvim"
export MANPAGER="less"
export TERMINAL="alacritty"
export BROWSER="brave"

alias nv='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
