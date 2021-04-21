# # exclde_list for fd
# exclude_list=(
#   node_modules
#   .deploy_git .git 
#   .cache 
#   '"*.nosync"' '"*conda*"'
#   Library '"*.photoslibrary"'
#   '"Virtual Machines.localized"'
#   'bundle' 'elpa' 
# )
# for ef in "${exclude_list[@]}"; do
#   EXCLUDE="$EXCLUDE --exclude ${ef}"
# done


# fzf
export FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border --multi --info=inline --exact'
export FZF_COMPLETION_TRIGGER=';'

export FZF_DEFAULT_COMMAND="fd -tf --no-ignore-vcs "
export FZF_ALT_C_COMMAND="fd -td --no-ignore-vcs  . ~"


_fzf_compgen_path() { fd --no-ignore-vcs   . "$1"}
_fzf_compgen_dir() { fd -td --no-ignore-vcs   . "$1"}
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

