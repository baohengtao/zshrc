export PlugDir=$HOME/.plugin  # plugin 存储位置
export ZPLUG_HOME=$PlugDir/zplug
source $ZPLUG_HOME/init.zsh

zplug "plugins/cp", from:"oh-my-zsh"
zplug "bigH/git-fuzzy", as:"command", use:"bin/git-fuzzy"
zplug "wfxr/forgit"
zplug "plugins/autojump", from:"oh-my-zsh"
zplug "Aloxaf/fzf-tab", use:"fzf-tab.plugin.zsh"
zplug "zsh-users/zsh-autosuggestions"
zplug "plugins/copyfile", from:"oh-my-zsh"
zplug "zsh-users/zsh-history-substring-search"
zplug "sindresorhus/pure", use:"pure.zsh", from:"github", as:"theme"
zplug "zdharma/fast-syntax-highlighting"
zplug "plugins/zsh-interactive-cd", from:"oh-my-zsh"
zplug "plugins/command-not-found", from:"oh-my-zsh"
zplug "plugins/copybuffer", from:"oh-my-zsh"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load 