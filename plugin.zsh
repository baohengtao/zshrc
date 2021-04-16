export ZSH_Plug="$HOME/.zsh_plug"  # plugin 存储位置
export OMZ=$ZSH_Plug/.oh-my-zsh
export ATG=$ZSH_Plug/.antigen.zsh

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh


# load oh-my-zsh plugins
plugins=(
  history #suggestions
  zsh-interactive-cd fasd   #navigation
  cp copyfile copydir copybuffer   #copy
  mosh docker pip #application
  git docker-compose vscode    #alias   
  colored-man-pages man  
  )


if ! [[ -e $OMZ ]]; then
   git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git $OMZ
fi
source $OMZ/oh-my-zsh.sh




[[ -e $ATG ]] || curl -L git.io/antigen > $ATG
source $ATG


antigen bundle zdharma/fast-syntax-highlighting 
antigen bundle zsh-users/zsh-autosuggestions  
antigen bundle zsh-users/zsh-history-substring-search 
antigen theme denysdovhan/spaceship-prompt
antigen apply

