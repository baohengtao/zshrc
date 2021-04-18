current_dir="${0%/*}"  # $0 当前文件； ${var%pattern} 将移除匹配的pattern

files=(
  theme.zsh  
  brew_package.zsh
  plugin.zsh
  keybind.zsh
  aliases.zsh)
   
for file in $files; do
  filepath=$current_dir/$file
  [[ -e $filepath ]] && source $filepath
done

zshrc_update(){
  git -C ${current_dir} push
  git -C ${current_dir} pull
}

