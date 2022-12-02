
if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source  "$ZDOTDIR/.p10k.zsh" 

autoload -Uz compinit # init completion system
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION 

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath' # remember to use single quote here!!!
# give a preview of commandline arguments when completing `kill`

current="${0%/*}"  
source "$current/aliases.zsh"
# source "$current/archieve/myplug/load_plug.zsh"
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


