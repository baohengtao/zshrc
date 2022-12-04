# 使用 `;` 触发搜索
export FZF_COMPLETION_TRIGGER=';'
export FZF_TMUX_HEIGHT='75%'
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

# _fzf_comprun() {
#   local command=$1
#   shift
#   case "$command" in
#     cd)           fzf "$@" --preview 'exa --icons --tree -L2 {} | head -200' ;;
#     export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
#     ssh)          fzf "$@" --preview 'dig {}' ;;
#     *)            fzf "$@" ;;
#   esac
# }

_comp_options+=(globdots) # enable hidden file completion
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-s:toggle' 'ctrl-a:toggle-all'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa --icons --tree -L2 $realpath | head -200'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
# disable preview for options and argument
zstyle ':fzf-tab:complete:*:options' fzf-preview 
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
export LESSOPEN='|~/.lessfilter %s'


#Note: This doesn't work if you are using Homebrew's completion for git.
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
	'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'

# brew preview support
zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'