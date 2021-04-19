

export PlugDir=$HOME/.plugin  # plugin 存储位置
export ADOTDIR=$PlugDir/antigen
mkdir -p $ADOTDIR
 [[ -e $ADOTDIR/antigen.zsh ]] || curl -L git.io/antigen > "$ADOTDIR/antigen.zsh"
source "$ADOTDIR/antigen.zsh"




antigen theme $THEME_PROMPT --branch=main

antigen use oh-my-zsh
antigen bundle autojump
antigen bundle command-not-found
antigen bundle zsh-interactive-cd
antigen bundle cp
antigen bundle copyfile
antigen bundle copybuffer

antigen bundle zsh-users/zsh-history-substring-search 
antigen bundle zsh-users/zsh-autosuggestions 
antigen bundle zdharma/fast-syntax-highlighting

antigen bundle wfxr/forgit
antigen bundle bigH/git-fuzzy

antigen apply




