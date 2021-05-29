plug_dir="${0%/*}"  # $0 当前文件； ${var%pattern} 将移除匹配的pattern
files=(
  # theme
  powerlevel10k/powerlevel9k.zsh-theme
  fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
  # search
  zsh-history-substring-search/zsh-history-substring-search.zsh
  # tool
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
# for plugin zsh-history-substring-search
bindkey  '^P' history-substring-search-up
bindkey  '^N' history-substring-search-down


function empty {

zplug "plugins/colored-man-pages", from:"oh-my-zsh"
## 补全
zplug "zsh-users/zsh-completions"
# zplug "Aloxaf/fzf-tab", use:"fzf-tab.plugin.zsh"
zplug "changyuheng/zsh-interactive-cd"
# zplug "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
## 目录跳转
zplug "plugins/fasd", from:"oh-my-zsh"
## mix
zplug "plugins/command-not-found", from:"oh-my-zsh"
}
