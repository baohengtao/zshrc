autoload -Uz compinit # init completion system
compinit
current_dir="${0%/*}"  # $0 当前文件； ${var%pattern} 将移除匹配的pattern

files=(
  parameter.zsh
  aliases.zsh
  function/package.zsh
  plugin.zsh
  fzf.zsh
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


