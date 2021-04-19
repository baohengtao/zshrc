# brew
alias bs='brew search'
alias bsd='brew search --desc'
alias bis='brew install'
alias bisc='brew install --cask'
alias brewup='brew -v update && brew -v upgrade && brew cask upgrade && brew -v cleanup --prune=5 && brew doctor'
# history
alias h='history'
alias hs='history | grep'
alias hsi='history | grep -i'

# cd
setopt autocd
alias ...='cd ../../'
alias d="cd -"
alias less="less -r"

# fasd alias
alias v='f -e "$EDITOR"'
alias o='a -e xdg-open'
alias v='f -e vim' # quick opening files with vim
alias m='f -e mplayer' # quick opening files with mplayer
alias o='a -e xdg-open' # quick opening files with xdg-open
# self-defined
alias dcursor='echo -ne "\e[5 q"'
alias typora="open -a typora" 

#program
alias vi=vim
alias vim=nvim
alias python='python3'
alias pip='pip3'
#shorthand
alias s=neofetch # s means system
alias cs=cowsay
alias ra=ranger
alias c=clear
#better default
alias sudo='sudo -E' #keep user environment
alias rm="trash -v"
alias mv="mv -i -v"
alias cp="cp -v"
# ls
alias ls='lsd'
alias ll='lsd --blocks permission,links,user,group,size,date,name'
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'




alias dud='du -d 1 -h'
alias duf='du -sh *'

alias h='history'
alias sortnr='sort -n -r'



alias rsync-copy="rsync -avz --progress -h"
alias rsync-move="rsync -avz --progress -h --remove-source-files"
alias rsync-update="rsync -avzu --progress -h"
alias rsync-synchronize="rsync -avzu --delete --progress -h"


alias dl="docker ps -l -q"
alias dps="docker ps"
alias dpa="docker ps -a"
alias di="docker images"
drm() { docker rm $(docker ps -a -q); } # Remove all containers
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'" # Get container IP
alias dkd="docker run -d -P" # Run deamonized container, e.g., $dkd base /bin/echo hello
alias dki="docker run -i -t -P" # Run interactive container, e.g., $dki base /bin/bash
alias dex="docker exec -i -t" # Execute interactive container, e.g., $dex base /bin/bash
dstop() { docker stop $(docker ps -a -q); } # Stop all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)' # Stop and Remove all containers
dri() { docker rmi $(docker images -q); } # Remove all images
dbu() { docker build -t=$1 .; } # Dockerfile build, e.g., $dbu tcnksm/test 
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }  # Show all alias related docker
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; } # Bash into running container







# zsh is able to auto-do some kungfoo
# depends on the SUFFIX :)
# auto open in relative application when file typed.
# 

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'



alias pixea="open -a pixea" 
EDITOR=${EDITOR:-vi}
BROWSER=${BROSER:-safari}
XIVIEWER=${XIVIEWER:-open}

autoload -Uz is-at-least
if is-at-least 4.2.0; then
  # open browser on urls
  if [[ -n "$BROWSER" ]]; then
    _browser_fts=(htm html de org net com at cx nl se dk)
    for ft in $_browser_fts; do alias -s $ft='$BROWSER'; done
  fi

  _editor_fts=(cpp cxx cc c hh h inl asc txt TXT tex)
  for ft in $_editor_fts; do alias -s $ft='$EDITOR'; done


  if [[ -n "$XIVIEWER" ]]; then
    _image_fts=(jpg jpeg png gif mng tiff tif xpm)
    for ft in $_image_fts; do alias -s $ft='$XIVIEWER'; done
  fi

  _media_fts=(ape avi flv m4a mkv mov mp3 mpeg mpg ogg ogm rm wav webm)
  for ft in $_media_fts; do alias -s $ft=mplayer; done

  _open_fts=(md)
   for ft in $_open_fts; do alias -s $ft=open; done


fi

