export ZSH_DIR="${0%/*}"  # $0 当前文件； ${var%pattern} 将移除匹配的pattern

files=(
  env_private.zsh 
  env.zsh
  plugin.zsh
  plugin_sys.zsh
  theme.zsh  
  keybind.zsh
  aliases.zsh)
   
for file in $files; do
  filepath=$ZSH_DIR/$file
  [[ -e $filepath ]] && source $filepath
done


