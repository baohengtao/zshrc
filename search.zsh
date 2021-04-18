## history
DATA_PATH=${DATA_PATH:-"$HOME/.data"}
HISTFILE=$DATA_PATH/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt SHARE_HISTORY

# exclde_list for fd
exclude_list=(
  node_modules
  .deploy_git .git  
  '"*.nosync"' '"*conda*"'
  Library '"*.photoslibrary"'
  '"Virtual Machines.localized"'
  'bundle' 'elpa'
)
for ef in "${exclude_list[@]}"; do
  EXCLUDE="$EXCLUDE --exclude ${ef}"
done

alias fd="fd $EXCLUDE"
# fzf
export FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border --multi --info=inline'
export FZF_COMPLETION_TRIGGER='>'
# search file; follow symbolic link; include hidden files but exclude .git
export FZF_DEFAULT_COMMAND="fd --type file --follow -IH $EXCLUDE"

#  使用 fd 生产路径
_fzf_compgen_path() { fd -HI $EXCLUDE  . "$1"}
_fzf_compgen_dir() { fd -HI --type d $EXCLUDE  . "$1"}
# 对 部分命令的补全 显示预览
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}
