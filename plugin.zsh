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

sys_plugin(){
  if [ -f /usr/local/etc/profile.d/autojump.sh ]; then
  . /usr/local/etc/profile.d/autojump.sh
  else
    echo "\e[33m Warn: Autojump not fund\e[0m" 
    echo 'Run "brew install autojump" '
    echo 'Or you can run "install_brew_package" to install all missings.'
  fi


  if [ ${+commands[fasd]} ]; then
    eval "$(fasd --init auto)"
    alias v='f -e "$EDITOR"'
    alias o='a -e xdg-open'
    alias v='f -e vim' # quick opening files with vim
    alias m='f -e mplayer' # quick opening files with mplayer
    alias o='a -e xdg-open' # quick opening files with xdg-open
  else
    echo "\e[33m Warn: fasd is not installed \e[0m"
    echo 'Run `brew install autojump` please'
    echo 'Or you can run "install_brew_package" to install all missings.'


  fi
}




load_omz
load_zinit
sys_plugin
