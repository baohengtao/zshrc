autoload -Uz compinit # init completion system
[[ -d "$ZDOTDIR/data" ]] || mkdir -p "$ZDOTDIR/data"
compinit -d $ZDOTDIR/data/zcompdump-$ZSH_VERSION


current="${0%/*}"
source "$current/aliases.zsh"
source "$current/plug.zsh"
source "$current/exiftool.zsh"
source "$current/fzf.zsh"

## history
export HISTFILE=$ZDOTDIR/data/zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt appendhistory
setopt SHARE_HISTORY
export BAT_THEME="Dracula"


