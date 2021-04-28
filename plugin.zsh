ZPLUG_GIT=https://github.com/zplug/zplug
[[ -d $ZPLUG_HOME ]] ||  git clone  $ZPLUG_GIT $ZPLUG_HOME
source $ZPLUG_HOME/init.zsh


# theme
zplug romkatv/powerlevel10k, as:theme, depth:1
zplug "zdharma/fast-syntax-highlighting"
zplug "plugins/colored-man-pages", from:"oh-my-zsh"


## git
zplug "bigH/git-fuzzy", as:"command", use:"bin/git-fuzzy"
zplug "wfxr/forgit"


## 补全
zplug "zsh-users/zsh-completions"
# zplug "Aloxaf/fzf-tab", use:"fzf-tab.plugin.zsh"
zplug "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
## 目录跳转
zplug "plugins/fasd", from:"oh-my-zsh"

## mix
zplug "plugins/command-not-found", from:"oh-my-zsh"
zplug "djui/alias-tips"

### vim
#zplug "jeffreytse/zsh-vi-mode"
#zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
#MODE_CURSOR_VIINS="#00ff00 blinking bar"
#MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
#MODE_CURSOR_VICMD="green block"
#MODE_CURSOR_SEARCH="#ff00ff blinking underline"
#MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
#MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"
#unset MODE_CURSOR_DEFAULT


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then; echo; zplug install; fi
fi

# Then, source plugins and add commands to $PATH
zplug load 
