## 初始化环境

### 安装

```zsh
ZDOTDIR="$HOME/.config/zsh"
git clone git@github.com:baohengtao/zshrc.git $ZDOTDIR/main
cp $ZDOTDIR/main/zshenv .zshenv
cp $ZDOTDIR/main/zshrc $ZDOTDIR/.zshrc
```

### XDG目录

在`~/.zshenv` 中设置XDG环境变量

```shell
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
```

### 添加路径

```sh
export MYPATH="$MYPATH:$HOME/.local/bin"
export MYPATH="$MYPATH:$PATH"
```



### 设置代理

```shell
HTTP_PORT=7890
SOCKS_PORT=7891
SERVER="127.0.0.1"
function proxy_set(){
	export "http_proxy=http://127.0.0.1:$HTTP_PORT"
	export "https_proxy=http://127.0.0.1:$HTTP_PORT"
	export "all_proxy=socks5://127.0.0.1:$HTTP_PORT"
}

function proxy_unset(){
   unset {http,https,all}_proxy
}
```



## 程序安装

### neovim

树莓派上安装:

```shell
sudo snap install --classic nvim
```
若无sudo权限, 可选择`nvim.appimage`

安装ctags

```shell
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure --prefix=$HOME/.local/ # defaults to /usr/local
make && make install
```



### Python

#### virtualenv

```shell
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export WORKON_HOME="$HOME/.local/workon" 
```

#### pipx

```shell
export MYPATH="$MYPATH:$HOME/.local/pipx/bin"
export PIPX_BIN_DIR="$HOME/.local/pipx/bin"
export PIPX_HOME="$HOME/.local/pipx"
```

#### pyenv

```shell
export MYPATH="$MYPATH:$HOME/.local/pyenv/bin"
export PYENV_ROOT="$HOME/.local/pyenv"
```



### NodeJS

设置环境变量如下

```shell
export NODE_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/export N_PREFIX="$HOME/.local/n"export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"export MYPATH="$MYPATH:$HOME/.local/yarn/bin"export MYPATH="$MYPATH:$HOME/.local/n/bin"
```

安装 

```shell
sudo npm install -g n
n stable
sudo npm install --global yarn
yarn global add neovim # 添加对neovim的支持
```





## 配置文件路径

```shell
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskeyexport LESSHISTFILE="$XDG_CACHE_HOME"/less/historyexport DOOMDIR="$XDG_CONFIG_HOME"/emacs-doom-config
```

