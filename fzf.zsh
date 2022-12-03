

# 使用 `;` 触发搜索
export FZF_COMPLETION_TRIGGER=';'
# 设置UI选项
export FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border --multi --info=inline --exact'

export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS --preview 'exa --icons --tree -L2 {} | head -200'"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --preview '( ( [ ! -f {} ] && exa --icons  --tree -L2 {} | head -200) || ( highlight -O ansi {} || bat --color=always {})  ) 2> /dev/null' "
#export FZF_CTRL_R_OPTS=''
#export FORGIT_FZF_DEFAULT_OPTS="--cycle --reverse" 
# 设置执行命令
export FZF_DEFAULT_COMMAND="fd"
export FZF_ALT_C_COMMAND="fd --type d --max-depth 4 --hidden  . ~"
export FZF_CTRL_T_COMMAND="fd"
# 设置路径生产使用的函数
_fzf_compgen_path() { fd  --hidden --exclude ".git" . "$1"}
_fzf_compgen_dir() { fd --type d  --hidden   --exclude ".git" . "$1"}

_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf "$@" --preview 'exa --icons --tree -L2 {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}

# fzf-tab
FZF_TAB_COMMAND=(
    fzf-tmux
    --height=${FZF_TMUX_HEIGHT:=75%}
)
zstyle ":fzf-tab:*" command $FZF_TAB_COMMAND
_comp_options+=(globdots) # enable hidden file completion
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-s:toggle' 'ctrl-a:toggle-all'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa --icons --tree -L2 $realpath | head -200'
