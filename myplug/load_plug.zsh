

plug_dir="${0%/*}"  # $0 当前文件； ${var%pattern} 将移除匹配的pattern
files=(
  # theme
  powerlevel10k/powerlevel9k.zsh-theme
  fzf-tab/fzf-tab.plugin.zsh
  fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
  # search
  zsh-history-substring-search/zsh-history-substring-search.zsh
  # tool
  forgit/forgit.plugin.zsh
  alias-tips/alias-tips.plugin.zsh
  zsh-autosuggestions/zsh-autosuggestions.zsh
  # fzf
  zsh-interactive-cd/zsh-interactive-cd.plugin.zsh
  omz/arch-color-man.zsh
  fzf-fasd/fzf-fasd.plugin.zsh
  )

fpath=("$plug_dir/zsh-completions/src" "$plug_dir/poetry" $fpath)
for file in $files; do
  filepath=$plug_dir/$file
  if [[ -e $filepath ]]; then
    source $filepath
  else
    echo "${filepath}" not exist
  fi
done
# for plugin zsh-history-substring-search
bindkey  '^K' history-substring-search-up
bindkey  '^J' history-substring-search-down
# alias-tips.plugin
export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1
eval "$(fasd --init auto)"
THEME_CODE=Dracula

