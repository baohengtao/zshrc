autoload -Uz compinit # init completion system
compinit
current_dir="${0%/*}"  # $0 当前文件； ${var%pattern} 将移除匹配的pattern

files=(
  theme.zsh
  function/package.zsh
  # plg_anti.zsh
  # plg_zinit.zsh
  plg_zplug.zsh
  search.zsh
  aliases.zsh
  # keybind.zsh

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


if [[ $THEME_PROMPT == romkatv/powerlevel10k ]]; then
  P10K=$current_dir/.p10k.zsh
  [[ ! -f $P10K ]] || source  $P10K
fi
