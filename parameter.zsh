## plugin path
export PlugDir=$HOME/.plugin  # plugin 存储位置
export ZINIT_HOME=$PlugDir/zinit
export ZPLUG_HOME=$PlugDir/zplug
declare -A ZINIT
export ZINIT[HOME_DIR]=$ZINIT_HOME

## history
DATA_PATH=${DATA_PATH:-"$HOME/.data"}
mkdir -p $DATA_PATH
HISTFILE=$DATA_PATH/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt SHARE_HISTORY

EDITOR=nvim
BROWSER=open
XIVIEWER=open

# themes
THEME_CODE=Dracula
SPACESHIP_TIME_SHOW=false
SPACESHIP_USER_SHOW=false
SPACESHIP_HOST_SHOW=false
SPACESHIP_DIR_TRUNC=0
SPACESHIP_DIR_TRUNC_REPO=false

export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1





