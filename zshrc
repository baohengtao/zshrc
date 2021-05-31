PATH=$MYPATH
autoload -U colors && colors
source  "$ZDOTDIR/main/init.zsh"

# environment export

if [ $(command -v virtualenvwrapper.sh) ]; then
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
  export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
  source virtualenvwrapper.sh
fi

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
