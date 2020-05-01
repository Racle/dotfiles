# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/isl@0.18/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/isl@0.18/include"
export PKG_CONFIG_PATH="/home/linuxbrew/.linuxbrew/opt/isl@0.18/lib/pkgconfig"
export PATH="$HOME/scripts/:$PATH"
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH:$GOBIN
export ANSIBLE_INVENTORY=~/.ansible-hosts
#export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh

ZSH_DISABLE_COMPFIX=true
ZLE_RPROMPT_INDENT=0

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# POWERLEVEL9K_MODE='awesome-patched'
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker
  extract
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf-zsh
  zsh-better-npm-completion
)

source $ZSH/oh-my-zsh.sh

POWERLEVEL9K_CONTEXT_TEMPLATE="%n"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir_writable dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs time)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_STRATEGY=None
POWERLEVEL9K_STATUS_CROSS=true



alias o=xdg-open

#Disable bracketed paste (ctrl+v => ctrl+shift+v = \e[200~
unset zle_bracketed_paste

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte-*.sh
fi

alias set_xterm_color="export TERM=\"xterm-256color\""
alias set_screen_color="export TERM=\"screen-256color\""
alias gitmergedevtomaster="git checkout develop && git pull && git push && git checkout master && git pull && git merge develop && git pull && git push && git checkout develop && git pull"
alias spacesniffer="ncdu"
alias df='df -x"squashfs"'

# stop screen freezing
stty stop undef
stty start undef

[ -f ~/.docker_aliases ] && source ~/.docker_aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

return ok
