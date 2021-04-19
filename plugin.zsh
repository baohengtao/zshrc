
source $ZPLUG_HOME/init.zsh

# theme
zplug "sindresorhus/pure", use:"pure.zsh", from:"github", as:"theme"
zplug "zdharma/fast-syntax-highlighting"


## git
zplug "bigH/git-fuzzy", as:"command", use:"bin/git-fuzzy"
zplug "wfxr/forgit"
zplug "plugins/git", from:"oh-my-zsh"

## 补全
zplug "Aloxaf/fzf-tab", use:"fzf-tab.plugin.zsh"
zplug "zsh-users/zsh-autosuggestions"


## 跳转
zplug "plugins/autojump", from:"oh-my-zsh"

## mix
zplug "plugins/command-not-found", from:"oh-my-zsh"







# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load 