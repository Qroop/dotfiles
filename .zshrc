# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

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

md-to-pdf(){
    curl --data-urlencode "markdown=$(cat $1)" --output $2 https://md-to-pdf.fly.dev/
}

# For a full list of active aliases, run `alias`.
if [[ -f ~/.zsh/alias ]]; then
  . ~/.zsh/alias
fi

if [[ -f ~/.zsh/paths ]]; then
  . ~/.zsh/paths
fi

if [[ -f ~/.zsh/scripts ]]; then
  . ~/.zsh/scripts
fi
