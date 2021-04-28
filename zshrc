
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/config/zsh/.p10k.zsh ]] || source ~/config/zsh/.p10k.zsh







# FZF keybinding and completions
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# clone my personal config
if ! [[ -d  "$ZDOTDIR/main" ]]; then
   git clone git@github.com:baohengtao/zshrc.git "$ZDOTDIR/main"    
fi
source  "$ZDOTDIR/main/init.zsh"


# nfasd: open nvim file with fasd
eval "$(register-python-argcomplete-menu nfasd)"
setopt NO_LIST_BEEP


# iterm2 integration
test -e /Users/htao/config/zsh/.iterm2_shell_integration.zsh && source /Users/htao/config/zsh/.iterm2_shell_integration.zsh || true

# environment export
autoload -U colors && colors
export https_proxy=http://127.0.0.1:6152
export http_proxy=http://127.0.0.1:6152
export all_proxy=socks5://127.0.0.1:6153

# Created by `pipx` on 2021-03-18 02:21:28
export PATH="$PATH:/Users/htao/.local/bin"





# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/htao/.local/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/htao/.local/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/htao/.local/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/htao/.local/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

