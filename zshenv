eval `/usr/libexec/path_helper -s`
export MYPATH="$MYPATH:$HOME/.local/bin"
export MYPATH="$MYPATH:$HOME/.local/pyenv/bin"
export MYPATH="$MYPATH:/Library/Frameworks/Python.framework/Versions/3.9/bin"
export MYPATH="$MYPATH:$HOME/.local/pipx/bin"
export MYPATH="$MYPATH:$HOME/.local/yarn/bin"
export MYPATH="$MYPATH:$HOME/.local/n/bin"
export MYPATH="$MYPATH:$HOME/.local/homebrew/bin"
export MYPATH="$MYPATH:/opt/local/bin"
export MYPATH="$MYPATH:/Applications/MacVim.app/Contents/bin"
export MYPATH="$MYPATH:/Applications/goneovim.app/Contents/MacOS"
export MYPATH="$MYPATH:/usr/local/bin"
export MYPATH="$MYPATH:/usr/local/opt/openssl@1.1/bin" 
export MYPATH="$MYPATH:/usr/local/opt/sqlite/bin" 
export MYPATH="$MYPATH:$PATH"


## XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

## PIP
export WORKON_HOME="$HOME/.local/workon" 
export PYENV_ROOT="$HOME/.local/pyenv"
export PIPX_HOME="$HOME/.local/pipx"
export PIPX_BIN_DIR="$HOME/.local/pipx/bin"

# Node
export NODE_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/
export N_PREFIX="$HOME/.local/n"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

## App
export VSCODE_EXTENSIONS="${XDG_DATA_HOME}/code-oss/extensions"
export ATOM_HOME="${XDG_DATA_HOME}/atom"

# config
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history


if [[ $(uname) == "Darwin" ]]; then
  export https_proxy=http://127.0.0.1:6152
  export http_proxy=http://127.0.0.1:6152
  export all_proxy=socks5://127.0.0.1:6153
fi




# for sysbrew
export LDFLAGS="-L/usr/local/opt/libffi/lib"
export CPPFLAGS="-I/usr/local/opt/libffi/include"
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"
