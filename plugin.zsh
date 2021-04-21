 ZPLUG_GIT=https://github.com/zplug/zplug
 if ! [[ -d $ZPLUG_HOME ]]; then
    git clone  $ZPLUG_GIT $ZPLUG_HOME
 fi

source $ZPLUG_HOME/init.zsh


# theme
zplug romkatv/powerlevel10k, as:theme, depth:1
zplug "zdharma/fast-syntax-highlighting"
zplug "plugins/colored-man-pages", from:"oh-my-zsh"


## git
zplug "bigH/git-fuzzy", as:"command", use:"bin/git-fuzzy"
zplug "wfxr/forgit"


## 补全
zplug "Aloxaf/fzf-tab", use:"fzf-tab.plugin.zsh"
zplug "zsh-users/zsh-autosuggestions"

## 目录跳转
zplug "plugins/fasd", from:"oh-my-zsh"
# zplug "plugins/autojump", from:"oh-my-zsh"

## mix
zplug "plugins/command-not-found", from:"oh-my-zsh"
zplug "djui/alias-tips"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then; echo; zplug install; fi
fi

# Then, source plugins and add commands to $PATH
zplug load 
