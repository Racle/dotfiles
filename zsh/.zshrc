# --- PATH ---
path=(
  $HOME/.local/bin
  $HOME/scripts
  $HOME/.cargo/bin
  $HOME/.dotnet/tools
  $HOME/.dotnet
  $HOME/.go/bin
  /usr/local/go/bin
  $HOME/go/bin
  $HOME/.npm-packages/bin
  /home/linuxbrew/.linuxbrew/bin
  $path
)

# --- Environment ---
export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/isl@0.18/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/isl@0.18/include"
export PKG_CONFIG_PATH="/home/linuxbrew/.linuxbrew/opt/isl@0.18/lib/pkgconfig"
export DOTNET_ROOT="$HOME/.dotnet"
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export ANSIBLE_INVENTORY=~/.ansible-hosts

# install npm packages globally without sudo
NPM_PACKAGES="${HOME}/.npm-packages"

# Lazy-load JAVA_HOME on first use
java_home_init() {
  unset -f java javac jar
  export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
  export PATH="$JAVA_HOME/bin:$PATH"
}
java()  { java_home_init && command java "$@"; }
javac() { java_home_init && command javac "$@"; }
jar()   { java_home_init && command jar "$@"; }

export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
export MANPAGER='nvim +Man!'
export EDITOR="nvim"
export VISUAL="nvim"

# Set npm config 'before' to 3 days ago on every new terminal
# This helps to avoid security issues with npm packages
# export NPM_BEFORE_DATE=$(date -d "3 days ago" +%Y-%m-%d)
# npm config set before=$NPM_BEFORE_DATE
alias NPM="SAFE_CHAIN_MINIMUM_PACKAGE_AGE_HOURS=0 npm"

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
ZSH_THEME="powerlevel10k/powerlevel10k"

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
  terraform
  ssh
)

source $ZSH/oh-my-zsh.sh


# https://github.com/lc/gau/issues/8#issuecomment-705351203
(( $+aliases[gau] )) && unalias gau

POWERLEVEL9K_CONTEXT_TEMPLATE="%n"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir_writable dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs time)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_STRATEGY=None
POWERLEVEL9K_STATUS_CROSS=true

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ "$TILIX_ID" ] || [ "$VTE_VERSION" ]; then
        source /etc/profile.d/vte-*.sh
fi

alias o=xdg-open
alias set_xterm_color="export TERM=\"xterm-256color\""
alias set_kitty="export TERM=\"xterm-kitty\""
alias set_screen_color="export TERM=\"screen-256color\""
alias gitmergedevtomaster="git checkout develop && git pull && git push && git checkout master && git pull && git merge develop && git pull && git push && git checkout develop && git pull"
alias spacesniffer="ncdu"
alias df='df -x"squashfs"'
alias tm='tmux new-session -A -s Racle'
alias tm1='tm'
alias tm2='tmux new-session -A -s Lonkero'
alias tm3='tmux new-session -A -s SSH'
alias tm4='tmux new-session -A -s Extras'
alias vim-rio='tmux split-window -v && tmux split-window -h && tmux resize-pane -t 2 -y 20 && tmux resize-pane -Z -t 1 && vim'
alias vim-php='tmux split-window -v && tmux resize-pane -t 2 -y 20 && tmux resize-pane -Z -t 1 && vim'
alias vim='nvim'
alias vi='nvim'
alias VIM='nvim --clean -u NONE -i NONE'
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
alias zssh="TERM=xterm-256color zssh"
# alias kubectl="sudo kubectl"
alias talosctl="TERM=xterm-256color talosctl"
alias aie="gh copilot explain"
alias k="kubectl"
alias cdir='cd "${_%/*}"'
# Clipboard: auto-detect Wayland vs X11
if (( $+commands[wl-copy] )) && [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
  alias -g C="| wl-copy"
  _clip_paste() { wl-paste }
else
  alias -g C="| xclip -selection clipboard"
  _clip_paste() { xclip -selection clipboard -o }
fi
# alias ai="gh copilot suggest -t shell"
ai() {
  # run copilot and copy the result to clipboard and print it to terminal
  gh copilot suggest -t shell "$@" && print -z "$(_clip_paste)"
}

json_encode() {
  if (( $+commands[wl-copy] )) && [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    echo -n "$1" | jq -R '.' | tr -d '\n' | wl-copy && echo "$(_clip_paste)"
  else
    echo -n "$1" | jq -R '.' | tr -d '\n' | xclip -r -selection clipboard && echo "$(_clip_paste)"
  fi
}

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

# for extra stuff
[[ ! -f ~/.zshrc-extra ]] || source ~/.zshrc-extra

# Screen dump pager: ctrl+shift+j (Ghostty pastes temp file path) then ctrl+o opens it in nvim
_clean_and_open() {
  local filepath="${BUFFER}"
  filepath="${filepath## }"  # trim leading spaces
  filepath="${filepath%% }"  # trim trailing spaces
  if [[ -z "$filepath" || ! -f "$filepath" ]]; then
    zle -M "No valid file path in buffer"
    return 1
  fi
  BUFFER=""
  zle accept-line
  # Clean: strip trailing whitespace, leading/trailing blank lines
  sed -i -e 's/\s*$//' -e '/./,$!d' -e ':a' -e '/^\n*$/{$d;N;ba' -e '}' "$filepath"
  nvim -c 'setlocal nomodifiable ft=man nonumber nolist showtabline=0 foldcolumn=0' \
       -c 'autocmd VimEnter * normal G' \
       +TerminalBufferClean "$filepath"
  rm -f "$filepath"
}
zle -N _clean_and_open
bindkey '^O' _clean_and_open

# Aikido  safe-chain https://github.com/AikidoSec/safe-chain
source ~/.safe-chain/scripts/init-posix.sh 2> /dev/null || echo "Aikido Safe-chain not installed"
