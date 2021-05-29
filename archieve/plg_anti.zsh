

export ADOTDIR=$ZDOTDIR/main/antigen
mkdir -p $ADOTDIR
 [[ -e $ADOTDIR/antigen.zsh ]] || curl -L git.io/antigen > "$ADOTDIR/antigen.zsh"
source "$ADOTDIR/antigen.zsh"




# antigen theme $THEME_PROMPT --branch=main
antigen use oh-my-zsh
# theme
antigen theme romkatv/powerlevel10k
antigen bundle colored-man-pages
antigen bundle zdharma/fast-syntax-highlighting

# git
antigen bundle wfxr/forgit
antigen bundle bigH/git-fuzzy

## 补全
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
# antigen bundle zsh-users/zsh-autosuggestions 
# bindkey  '^P' history-substring-search-up
# bindkey  '^N' history-substring-search-down
antigen bundle changyuheng/zsh-interactive-cd
antigen bundle fasd
# zplug "Aloxaf/fzf-tab", use:"fzf-tab.plugin.zsh"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

antigen bundle command-not-found


antigen apply




