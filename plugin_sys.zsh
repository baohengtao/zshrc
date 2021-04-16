[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# check if fasd is installed
if (( ! ${+commands[fasd]} )); then
  return
fi

eval "$(fasd --init auto)"
alias v='f -e "$EDITOR"'
alias o='a -e xdg-open'
# alias j='zz'
