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
  zsh-autosuggestions/zsh-autosuggestions.zsh
  # fzf
  zsh-interactive-cd/zsh-interactive-cd.plugin.zsh
  fzf-tab/fzf-tab.plugin.zsh
  myfzf/completion.zsh
  myfzf/key-bindings.zsh
  myfzf/fzf-setting.zsh
  omz/arch-color-man.zsh
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
# alias-tips.plugin
export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1
eval "$(fasd --init auto)"
THEME_CODE=Dracula

function empty {

zplug "plugins/colored-man-pages", from:"oh-my-zsh"
## 补全
zplug "zsh-users/zsh-completions"
# zplug "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
## mix
zplug "plugins/command-not-found", from:"oh-my-zsh"
}
