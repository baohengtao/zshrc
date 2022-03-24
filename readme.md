## 初始化环境

### 安装
1.添加如下内容至`~/.zshenv`, 以设置XDG路径以及ZSH配置路径: 
```zsh
## XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
```

2. 克隆仓库, 并加载`init.zsh`文件.
```zsh
git clone --recurse-submodules -j8 git@github.com:baohengtao/zshrc.git $ZDOTDIR/main
echo 'source  "$ZDOTDIR/main/init.zsh" ' >> $ZDOTDIR/.zshrc
```






#### pipx

```shell
export MYPATH="$MYPATH:$HOME/.local/pipx/bin"
export PIPX_BIN_DIR="$HOME/.local/pipx/bin"
export PIPX_HOME="$HOME/.local/pipx"
```


配置路径

```shell
## PYENV
export PATH="$PATH:/usr/local/bin"
export PYENV_ROOT="$HOME/.local/pyenv"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
```



### NodeJS

设置环境变量如下

```shell
export NODE_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/export N_PREFIX="$HOME/.local/n"
export MYPATH="$MYPATH:$HOME/.local/n/bin"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export MYPATH="$MYPATH:$HOME/.local/yarn/bin"
```

安装

```shell
brew install n
npm install --global yarn
yarn config set global-folder ~/.local/yarn
yarn config set dir ~/.local/yarn
yarn config set prefix ~/.local/yarn
yarn global add neovim # 添加对 neovim 的支持
```

### fasdf

```shell
brew install fasd
```

添加如下内容至 zshrc

```shell
eval "$(fasd --init auto)"
```

配置`~/.fasdrc` 如下

```shell
_FASD_DATA="$XDG_DATA_HOME/fasd"
_FASD_NOCASE=0
_FASD_SINK="$XDG_DATA_HOME/fasd.log"
#_FASD_BACKENDS="spotlight"

home_folder(){
 fd -td . "$HOME" -x echo "{}|1"
}

desk_folder(){
  fd -td . "$HOME/Desktop" -x echo "{}|1"
}

current_folder(){
 fd  -td . -x echo "$PWD/{}|1"
}

current_file(){
  fd  -x echo "$PWD/{}|1"
}

```








## 配置文件路径

```shell
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskeyexport LESSHISTFILE="$XDG_CACHE_HOME"/less/historyexport DOOMDIR="$XDG_CONFIG_HOME"/emacs-doom-config
```











## 设置代理

rpi 上安装 clash:

```shell
wget https://github.com/Dreamacro/clash/releases/download/v1.6.0/clash-linux-armv7-v1.6.0.gz
mv clash-linux-armv7-v1.6.0 ~/.local/bin/clash

```



```shell
HTTP_PORT=7890
SOCKS_PORT=7891
SERVER="127.0.0.1"
function proxy_set(){
	export "http_proxy=http://127.0.0.1:$HTTP_PORT"
	export "https_proxy=http://127.0.0.1:$HTTP_PORT"
	export "all_proxy=socks5://127.0.0.1:$SOCKS_PORT"
}

function proxy_unset(){
   unset {http,https,all}_proxy
}
```
对于 clash 可直接复制以下几行快速配置
```shell
export "http_proxy=http://127.0.0.1:7890"; export "https_proxy=http://127.0.0.1:7890"; export "all_proxy=socks5://127.0.0.1:7891"
```

