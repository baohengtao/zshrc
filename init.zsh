current_dir="${0%/*}"  # $0 当前文件； ${var%pattern} 将移除匹配的pattern
 
files=(
  parameter.zsh
  function/package.zsh
  myplug/load_plug.zsh
  aliases.zsh
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

# 使用 `;` 触发搜索
export FZF_COMPLETION_TRIGGER=';'
# 设置UI选项
export FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border --multi --info=inline --exact'

export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS --preview 'tree -C {} | head -200'"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --preview '( ( [ ! -f {} ] && tree -C {} | head -200) || ( highlight -O ansi {} || bat {})  ) 2> /dev/null' "
#export FZF_CTRL_R_OPTS=''
#export FORGIT_FZF_DEFAULT_OPTS="--cycle --reverse" 
# 设置执行命令
export FZF_DEFAULT_COMMAND="fd  --no-ignore-vcs "
export FZF_ALT_C_COMMAND="fd -td -H --no-ignore-vcs  . ~"
export FZF_CTRL_T_COMMAND="fd  --no-ignore-vcs "
# 设置路径生产使用的函数
_fzf_compgen_path() { fd --no-ignore-vcs -H  . "$1"}
_fzf_compgen_dir() { fd -td --no-ignore-vcs -H   . "$1"}

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

