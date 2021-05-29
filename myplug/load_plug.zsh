plug_dir="${0%/*}"  # $0 当前文件； ${var%pattern} 将移除匹配的pattern
files=(
  powerlevel10k/powerlevel9k.zsh-theme
  )


for file in $files; do
  filepath=$plug_dir/$file
  if [[ -e $filepath ]]; then
    source $filepath
  else
    echo "${filepath}" not exist
  fi
done

