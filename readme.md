Add following to `~/.zshrc`
```shell
export https_proxy=http://127.0.0.1:6152
export http_proxy=http://127.0.0.1:6152
export all_proxy=socks5://127.0.0.1:6153

ZSH_DIR=$HOME/.config/zsh
if ! [[ -d $ZSH_DIR ]]; then
   git clone git@github.com:baohengtao/zshrc.git $ZSH_DIR
fi
source  $ZSH_DIR/init.zsh
```