ZPLUG_GIT=https://github.com/zplug/zplug
ZPLUG_HOME="$ZDOTDIR/main/zplug"
#ZPLUG_GIT=https://gitee.com/herun/zplug.git
[[ -d $ZPLUG_HOME ]] ||  git clone  $ZPLUG_GIT $ZPLUG_HOME
source $ZPLUG_HOME/init.zsh


# theme
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zdharma/fast-syntax-highlighting"
zplug "plugins/colored-man-pages", from:"oh-my-zsh"


## git
zplug "bigH/git-fuzzy", as:"command", use:"bin/git-fuzzy"
zplug "wfxr/forgit"


## 补全
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
# zplug "Aloxaf/fzf-tab", use:"fzf-tab.plugin.zsh"
zplug "changyuheng/zsh-interactive-cd"
# zplug "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
## 目录跳转
zplug "plugins/fasd", from:"oh-my-zsh"

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
