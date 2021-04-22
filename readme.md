Add following to `~/.zshrc`
```shell
ZSH_DIR=$HOME/.config/zsh
if ! [[ -d $ZSH_DIR ]]; then
   git clone git@github.com:baohengtao/zshrc.git $ZSH_DIR
fi
source  $ZSH_DIR/init.zsh
```



Needed Package: 

- File: fzf fasd lsd ranger transh-cli
- Develop: neovim  zsh git python
- System: 

