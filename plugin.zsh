export ZSH_Plug=$HOME/.zsh_plug  # plugin 存储位置



init_zinit(){
  if [[ ! -f $ZSH_Plug/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$ZSH_Plug/.zinit" && command chmod g-rwX "$ZSH_Plug/.zinit"
    command git clone https://github.com/zdharma/zinit "$ZSH_Plug/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
  fi
  source "$ZSH_Plug/.zinit/bin/zinit.zsh"
}

load_theme(){
  if [[ $THEME_PROMPT == sindresorhus/pure ]]; then
    zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
  fi
  zinit light $THEME_PROMPT
  zinit wait lucid for zdharma/fast-syntax-highlighting 
}

load_plug(){
  zinit wait lucid for \
        zdharma/history-search-multi-word \
        zsh-users/zsh-history-substring-search  \
        ael-code/zsh-colored-man-pages
  zinit load zsh-users/zsh-autosuggestions
  
}
load_navi(){
   plugins=(
    zsh-interactive-cd   #depend on fzf
    autojump 
    )
  for pl in "${plugins[@]}" ; do
    zinit wait lucid for "OMZP::${pl}"
  done

}

load_omz(){
  plugins=(
    history 
    #suggestions
    cp copyfile copydir copybuffer   #copy
    mosh  pip #application
    git  vscode  #alias 
    # colored-man-pages 
    fzf
    # fasd
    command-not-found
    )
  for pl in "${plugins[@]}" ; do
    zinit wait lucid for "OMZP::${pl}"
  done
}


post_zinit(){
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit
}


init_zinit
load_theme
load_plug
load_navi
load_omz
post_zinit


