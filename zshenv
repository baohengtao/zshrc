ZDOTDIR="$HOME/config/zsh"

## XDG
export XDG_CONFIG_HOME="$HOME/config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export VSCODE_EXTENSIONS="${XDG_DATA_HOME:-~/.local/share}/code-oss/extensions"
export ATOM_HOME="${XDG_DATA_HOME}/atom"


export CONDARC="$XDG_CONFIG_HOME/conda/condarc"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"


export EDITOR=nvim
