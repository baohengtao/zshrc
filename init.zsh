current_dir="${0%/*}"  # $0 当前文件； ${var%pattern} 将移除匹配的pattern
 
files=(
  parameter.zsh
  function/package.zsh
  myplug/load_plug.zsh
  # plugin.zsh
  # antigen.zsh
  fzf.zsh
  aliases.zsh
  )


for file in $files; do
  filepath=$current_dir/$file
  if [[ -e $filepath ]]; then
    source $filepath
  else
    echo "${filepath}" not exist
  fi
done

zshrc_update(){
  git -C ${current_dir} push
  git -C ${current_dir} pull
}


