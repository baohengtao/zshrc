PATH=$MYPATH
if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source  "$ZDOTDIR/.p10k.zsh" 

# clone my personal config
if ! [[ -d  "$ZDOTDIR/main" ]]; then
   git clone git@github.com:baohengtao/zshrc.git "$ZDOTDIR/main"    
fi
source  "$ZDOTDIR/main/init.zsh"

# environment export
autoload -U colors && colors

if [ $(command -v virtualenvwrapper.sh) ]; then
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
  export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
  source virtualenvwrapper.sh
fi

# fzf
FZF_PATH="/Users/htao/.local/bin/lib/fzf/shell"
[[ $- == *i* ]] && source "$FZF_PATH/completion.zsh" 2> /dev/null
source "$FZF_PATH/key-bindings.zsh"

# >>> conda initialize >>>
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

