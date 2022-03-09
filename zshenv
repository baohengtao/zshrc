## XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"


# pyenv
export PYENV_ROOT="$HOME/.local/pyenv"
## PIPX
export PIPX_HOME="$HOME/.local/pipx"
export PIPX_BIN_DIR="$HOME/.local/pipx/bin"
# Node
export NODE_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/
export N_PREFIX="$HOME/.local/n"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# config
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export PYTHONSTARTUP="$XDG_CONFIG_HOME/ipython/pythonstartup"
export PTPYTHON_CONFIG_HOME="$XDG_CONFIG_HOME/ptpython"

## App
export ATOM_HOME="${XDG_DATA_HOME}/atom"


## PROXY
export https_proxy=http://127.0.0.1:6152
export http_proxy=http://127.0.0.1:6152
export all_proxy=socks5://127.0.0.1:6153
