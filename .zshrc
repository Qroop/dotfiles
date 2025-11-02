# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

setopt +o nomatch


ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	you-should-use
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

setopt CORRECT

# For a full list of active aliases, run `alias`.
if [[ -f ~/.zsh/alias.sh ]]; then
  . ~/.zsh/alias.sh
fi

if [[ -f ~/.zsh/paths.sh ]]; then
  . ~/.zsh/paths.sh
fi

if [[ -f ~/.zsh/scripts.sh ]]; then
  . ~/.zsh/scripts.sh
fi

