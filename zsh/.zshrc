# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/isl@0.18/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/isl@0.18/include"
export PKG_CONFIG_PATH="/home/linuxbrew/.linuxbrew/opt/isl@0.18/lib/pkgconfig"
export PATH="$HOME/scripts/:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.dotnet:$PATH"
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH:$GOBIN
export ANSIBLE_INVENTORY=~/.ansible-hosts
# install npm packages globally without sudo
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
export PATH="$PATH:/home/vvi/.dotnet/tools"
export JAVA_HOME="/usr/lib/jvm/default-java"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
export MANPAGER='nvim +Man!'
export EDITOR="nvim"
export VISUAL="nvim"

#export TERM="xterm-256color"


# Automatically update zsh every 60 days
DISABLE_UPDATE_PROMPT=true
UPDATE_ZSH_DAYS=60

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_DISABLE_COMPFIX=true
ZLE_RPROMPT_INDENT=0
DISABLE_MAGIC_FUNCTIONS=true

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
  autoupdate
)

source $ZSH/oh-my-zsh.sh

POWERLEVEL9K_CONTEXT_TEMPLATE="%n"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir_writable dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs time)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_STRATEGY=None
POWERLEVEL9K_STATUS_CROSS=true

#Disable bracketed paste (ctrl+v => ctrl+shift+v = \e[200~
# unset zle_bracketed_paste

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte-*.sh
fi


# vi mode
  # bindkey -v
  # source "$HOME/.fzf.zsh"
  # export KEYTIMEOUT=1
  # # add ctrl+p/n support
  # bindkey "^P" up-line-or-history
  # bindkey "^N" down-line-or-history
  # # fix home/end keys
  # bindkey "^[[H" beginning-of-line
  # bindkey "^[[F" end-of-line

alias o=xdg-open
alias set_xterm_color="export TERM=\"xterm-256color\""
alias set_screen_color="export TERM=\"screen-256color\""
alias gitmergedevtomaster="git checkout develop && git pull && git push && git checkout master && git pull && git merge develop && git pull && git push && git checkout develop && git pull"
alias spacesniffer="ncdu"
alias df='df -x"squashfs"'
alias tm='tmux new-session -A -s Racle'
alias tm2='tmux new-session -A -s Lonkero'
alias tm3='tmux new-session -A -s ssh'
alias vim-rio='tmux split-window -v && tmux split-window -h && tmux resize-pane -t 2 -y 20 && tmux resize-pane -Z -t 1 && vim'
alias vim-php='tmux split-window -v && tmux resize-pane -t 2 -y 20 && tmux resize-pane -Z -t 1 && vim'
alias vim='nvim'
alias vi='nvim'
alias r='ranger'
alias t='todo-txt'
alias _kill-tmux='kill -9 $(pidof tmux)'
up() { local x='';for i in $(seq ${1:-1});do x="$x../"; done;cd $x; }
# = <laskukaava>
function = { echo "$@" | bc -l }
alias calc="="
alias gp="git pull"
alias gP="git push"
alias lg="lazygit"
# hax fix for https://github.com/kovidgoyal/kitty/issues/1139
alias ssh="TERM=xterm-256color ssh"
alias kubectl="sudo kubectl"

# stop screen freezing
stty stop undef
stty start undef
stty -ixon

export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!{.git,node_modules,.idea,.vscode,.history}'"

[ -f ~/.docker_aliases ] && source ~/.docker_aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[ -f ~/.p10k-server.zsh ] && source ~/.p10k-server.zsh || [ -f ~/.p10k.zsh ] && source ~/.p10k.zsh

if [ -f ~/.p10k-server.zsh ]; then
  source ~/.p10k-server.zsh
else
  [ -f ~/.p10k.zsh ] && source ~/.p10k.zsh
fi

# for server
[[ ! -f ~/.zshrc-server ]] || source ~/.zshrc-server

return ok
