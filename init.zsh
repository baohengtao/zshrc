if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source  "$ZDOTDIR/.p10k.zsh" 

autoload -Uz compinit # init completion system
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION 


current="${0%/*}"  
source "$current/aliases.zsh"
source "$current/myplug/load_plug.zsh"
source "$current/exiftool.zsh"

## history
export HISTFILE=$XDG_DATA_HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt appendhistory
setopt SHARE_HISTORY
export BAT_THEME="Dracula"
