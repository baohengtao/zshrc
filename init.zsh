current_dir="${0%/*}"  # $0 当前文件； ${var%pattern} 将移除匹配的pattern

files=(
  brew_package.zsh
  env.zsh
  plugin.zsh
  plugin_sys.zsh
  theme.zsh  
  keybind.zsh
  aliases.zsh)
   
for file in $files; do
  filepath=$current_dir/$file
  [[ -e $filepath ]] && source $filepath
done


