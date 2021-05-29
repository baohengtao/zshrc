```zsh
ZDOTDIR="$HOME/.config/zsh"
git clone https://github.com/baohengtao/zshrc $ZDOTDIR/main
cd $ZDOTDIR && ln -s main/zshrc .zshrc
cd && ln -s $ZDOTDIR/main/zshenv .zshenv
```

## Install Step
```zsh
git clone git@github.com:baohengtao/zshrc.git myzsh.repo
source myzsh.repo/zshenv
mv myzsh.repo $ZDOTDIR/main
ln -s $ZDOTDIR/main/zshenv .zshenv
ln -s $ZDOTDIR/main/zshrc $ZDOTDIR/.zshrc

```
