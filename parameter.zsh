
autoload -Uz compinit # init completion system
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION 

# ## XDG
# export XDG_CONFIG_HOME="$HOME/config"
# export XDG_CACHE_HOME="$HOME/.cache"
# export XDG_DATA_HOME="$HOME/.local/share"


## history
HISTFILE=$XDG_DATA_HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt SHARE_HISTORY

export EDITOR=nvim
export BROWSER=open
export XIVIEWER=pixea
export Player=iina

# themes
THEME_CODE=Dracula
SPACESHIP_TIME_SHOW=false
SPACESHIP_USER_SHOW=false
SPACESHIP_HOST_SHOW=false
SPACESHIP_DIR_TRUNC=0
SPACESHIP_DIR_TRUNC_REPO=false

export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1






