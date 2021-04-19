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
  .cache 
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
export FZF_DEFAULT_COMMAND="fd --type file -I $EXCLUDE"
_fzf_compgen_path() { fd -I   . "$1"}
_fzf_compgen_dir() { fd --type d -I    . "$1"}

# 对 部分命令的补全 显示预览
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    bat)            fzf "$@" --preview 'bat {}';;
    *)            fzf "$@" ;;
  esac
}

