export PlugDir=$HOME/.plugin  # plugin 存储位置
export ZINIT_HOME=$PlugDir/zinit
declare -A ZINIT

init_zinit(){
  export ZINIT[HOME_DIR]=$ZINIT_HOME
  if [[ ! -f $ZINIT_HOME/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$ZINIT_HOME" && command chmod g-rwX "$ZINIT_HOME"
    command git clone https://github.com/zdharma/zinit "$ZINIT_HOME/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
  fi
  source "$ZINIT_HOME/bin/zinit.zsh"
}

load_theme(){
  if [[ $THEME_PROMPT == sindresorhus/pure ]]; then
    zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
  fi
  zinit light $THEME_PROMPT
  zinit wait lucid for zdharma/fast-syntax-highlighting 
}

load_fzf(){
  zinit ice wait'2' lucid as"program" pick"bin/git-fuzzy"
  zinit light bigH/git-fuzzy
  # A utility tool powered by fzf for using git interactively.
  zinit load wfxr/forgit
  
  # zinit ice  lucid as"program" pick"fzf-tab.plugin.zsh"
  # zinit load Aloxaf/fzf-tab
  # zinit load sainnhe/tmux-fzf
}

load_plug(){
  # zinit wait lucid for zsh-users/zsh-history-substring-search  
  zinit load zsh-users/zsh-history-substring-search 
  # zinit load marlonrichert/zsh-autocomplete
  zinit load zsh-users/zsh-autosuggestions 

  
}

load_omz(){
  plugins=(
    cp copyfile  copybuffer   #copy
    # mosh  pip #application
    # git  vscode  #alias 
    autojump #git
    command-not-found
    zsh-interactive-cd
    
    )
 


  for pl in "${plugins[@]}" ; do
    zinit wait lucid for "OMZP::${pl}"
  done
  zinit wait lucid for "OMZL::clipboard.zsh"
}


post_zinit(){
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit
}


init_zinit
load_plug
load_fzf
load_omz
load_theme
post_zinit


