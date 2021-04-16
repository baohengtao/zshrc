if [ -f /usr/local/etc/profile.d/autojump.sh ]; then
 . /usr/local/etc/profile.d/autojump.sh
else
  echo "\e[33m Warn: Autojump is not installed\e[0m" 
fi


if [ ${+commands[fasd]} ]; then
  eval "$(fasd --init auto)"
  alias v='f -e "$EDITOR"'
  alias o='a -e xdg-open'
  alias v='f -e vim' # quick opening files with vim
  alias m='f -e mplayer' # quick opening files with mplayer
  alias o='a -e xdg-open' # quick opening files with xdg-open
else
  echo "\e[33m Warn: fasd is not installed \e[0m"
fi



