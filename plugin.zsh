export ZSH_Plug="～/.zsh_plug"  # plugin 存储位置
export OMZ=$ZSH_Plug/.oh-my-zsh
export ATG=$ZSH_Plug/.antigen.zsh


# load oh-my-zsh plugins
plugins=(
  history #suggestions
  zsh-interactive-cd fasd autojump   #navigation
  cp copyfile copydir copybuffer   #copy
  mosh docker pip #application
  git docker-compose vscode    #alias   
  colored-man-pages man  
  )
if ! [[ -e $OMZ ]]; then
   git clone https://github.com/ohmyzsh/ohmyzsh.git $OMZ
fi
source $OMZ/oh-my-zsh.sh



# load antigen plugins
antigen_plugin=(
  # apparance
  zdharma/fast-syntax-highlighting 
  # suggestion
  zsh-users/zsh-autosuggestions  
  zsh-users/zsh-history-substring-search 
)

[[ -e $ATG ]] || curl -L git.io/antigen > $ATG
source $ATG

for plugin in $antigen_plugin; do
  antigen bundle $plugin
done
antigen theme denysdovhan/spaceship-prompt
antigen apply

