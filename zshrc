export ZSH_DIR="${0%/*}"  # $0 当前文件； ${var%pattern} 将移除匹配的pattern
export ZSH=$ZSH_DIR/.oh-my-zsh
export ANTIGEN_PATH=$ZSH_DIR/.antigen.zsh

files=(
  theme.zsh  env_private.zsh env.zsh
  keybind.zsh
  ) 
for file in $files; do
  filepath=$ZSH_DIR/$file
  [[ -e $filepath ]] && source $filepath
done

# load oh-my-zsh plugins
plugins=(
  history #suggestions
  zsh-interactive-cd fasd autojump   #navigation
  cp copyfile copydir copybuffer   #copy
  mosh docker pip #application
  git docker-compose vscode    #alias   
  colored-man-pages man  
  zsh-autosuggestions  
  )
if ! [[ -e $ZSH ]]; then
   git clone https://github.com/ohmyzsh/ohmyzsh.git $ZSH
fi
source $ZSH/oh-my-zsh.sh



# load antigen plugins
antigen_plugin=(
  # apparance
  zdharma/fast-syntax-highlighting 
  # suggestion
  zsh-users/zsh-autosuggestions  
  zsh-users/zsh-history-substring-search 
)

[[ -e $ANTIGEN_PATH ]] || curl -L git.io/antigen > $ANTIGEN_PATH
source $ANTIGEN_PATH

for plugin in $antigen_plugin; do
  antigen bundle $plugin
done
antigen theme denysdovhan/spaceship-prompt
antigen apply




source $ZSH_DIR/aliases.zsh

