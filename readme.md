```zsh
export $ZDOTDIR="$HOME/zsh"
git clone https://github.com/baohengtao/zshrc $ZDOTDIR/main
cd $ZDOTDIR && ln -s main/zshrc .zshrc
cd && ln -s $ZDOTDIR/main/zshenv .zshenv
```
