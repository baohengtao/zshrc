
git clone git@github.com:baohengtao/zshrc.git myzsh.repo
source myzsh.repo/zshenv
mv myzsh.repo $ZDOTDIR/main
ln -s $ZDOTDIR/main/zshenv .zshenv
ln -s $ZDOTDIR/main/zshrc $ZDOTDIR/.zshrc
