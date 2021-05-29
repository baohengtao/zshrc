plug_dir="${0%/*}"  # $0 当前文件； ${var%pattern} 将移除匹配的pattern
files=(
  # theme
  powerlevel10k/powerlevel9k.zsh-theme
  fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
  zsh-history-substring-search/zsh-history-substring-search.zsh
  forgit/forgit.plugin.zsh
  alias-tips/alias-tips.plugin.zsh
  
  )


for file in $files; do
  filepath=$plug_dir/$file
  if [[ -e $filepath ]]; then
    source $filepath
  else
    echo "${filepath}" not exist
  fi
done

bindkey  '^P' history-substring-search-up
bindkey  '^N' history-substring-search-down
