export ZSH_Plug=$HOME/.zsh_plug  # plugin 存储位置



# load oh-my-zsh plugins

load_omz(){
  if ! [[ -e $ZSH_Plug/.oh-my-zsh ]]; then
    git clone  https://github.com/ohmyzsh/ohmyzsh.git $ZSH_Plug/.oh-my-zsh
  fi

  plugins=(
    history #suggestions
    zsh-interactive-cd   #navigation
    cp copyfile copydir copybuffer   #copy
    mosh docker pip #application
    git docker-compose vscode  #alias   
    colored-man-pages man   fzf
    )
  source $ZSH_Plug/.oh-my-zsh/oh-my-zsh.sh
}


load_zinit(){
  if [[ ! -f $ZSH_Plug/.zinit/bin/zinit.zsh ]]; then
      print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
      command mkdir -p "$ZSH_Plug/.zinit" && command chmod g-rwX "$ZSH_Plug/.zinit"
      command git clone https://github.com/zdharma/zinit "$ZSH_Plug/.zinit/bin" && \
          print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
          print -P "%F{160}▓▒░ The clone has failed.%f%b"
  fi


  source "$ZSH_Plug/.zinit/bin/zinit.zsh"
  zinit load zdharma/history-search-multi-word
  zinit light zdharma/fast-syntax-highlighting 
  zinit load  zsh-users/zsh-history-substring-search 
  zinit load  zsh-users/zsh-autosuggestions  
  zinit light denysdovhan/spaceship-prompt


  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit
}

load_omz
load_zinit