autoload -Uz compinit # init completion system
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION


current="${0%/*}"
source "$current/aliases.zsh"
source "$current/plug.zsh"
source "$current/exiftool.zsh"
source "$current/fzf.zsh"

## history
export HISTFILE=$XDG_DATA_HOME/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt appendhistory
setopt SHARE_HISTORY
export BAT_THEME="Dracula"


