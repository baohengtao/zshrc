alias reveal='open -R'
alias rmdir-empty='fd -H .DS_Store -x rm -v {}; fd -te -x grmdir -v'
# gun
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias find=gfind
  alias cp='gcp -v'
  alias mv='gmv -i -v'
  alias rm='grm'
else
  alias mv="mv -i -v"
  alias cp="cp -v"
fi
# rsync
alias rsync-default="rsync -aHzhvP"
alias rsync-copy="rsync-default"
alias rsync-move="rsync-default --remove-source-files"
alias rsync-update="rsync-default --update"
alias rsync-synchronize="rsync-default --update --delete-after"
alias rsync-existing="rsync-default --update --delete-after --existing"
# for raspberry
if command -v fdfind &> /dev/null; then
  alias fd=fdfind
fi

function set-proxy(){
  if [[ -z $HTTP_PORT || -z $SOCKS_PORT ]]; then
    echo "port not defined"
  else
    echo "set with http port $HTTP_PORT and socks port $SOCKS_PORT"
	  export "http_proxy=http://127.0.0.1:$HTTP_PORT"
	  export "https_proxy=http://127.0.0.1:$HTTP_PORT"
	  export "all_proxy=socks5://127.0.0.1:$SOCKS_PORT"
  fi
}

function unset-proxy(){
   unset {http,https,all}_proxy
}

alias dco=docker-compose
export EDITOR=nvim
export BROWSER=open
export XIVIEWER=pixea
export Player=iina
export FORGIT_NO_ALIASES=1

alias rpi="ssh rpi"
alias thu="ssh thu"
alias arch="ssh arch"

alias pandoc-tex="pandoc --mathjax --css ~/pandoc.css -s "
alias ft="fortune -e   tang300 song100 | cowsay"
alias deploy="j hugo; rm public/*; hugo; cd public; ga .; gcamr; gp"

alias hs="hugo server"
alias ty="typora"
alias q="exit"
alias nf="nfasd"
alias h=man
alias sysbrew="/usr/local/Homebrew/bin/brew"
alias :q=q
alias so="source $ZDOTDIR/.zshrc"
alias zshrc="nvim $ZDOTDIR/.zshrc"
alias ua="unalias"
alias ghweb="gh repo view --web"
# editor
alias nv="nvim"
alias nvc="nvim ."
alias gv="gvim"
alias vi="nvim"
alias ed="emacs --with-profile doom"
alias ev='emacs --with-profile vanilla'
# python
alias da="deactivate"
alias ca="conda activate"
alias cda="conda deactivate"
alias torch="conda activate torch"
alias main="workon main"
alias to=torch
alias jl="torch && jupyter-lab"
alias pi="pip install"
alias ci="conda install"
# for XDG
# alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"
# file
alias rsync-with-delete='rsync --delete --backup --backup-dir=./delete_files."$(date +%m%d-%H:%M:%S)"'

# suffix aliases
alias -s md=typora
# add color
alias grep='grep --color=auto'
alias ip='ip -color=auto'

if [[ $(uname) == "Darwin" ]]; then
  alias diff=colordiff
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
  alias diff='diff --color=auto'
fi

# alternative
if command -v trash &> /dev/null; then
  alias rm="trash -v"
fi

if command -v glances &> /dev/null; then
  alias top='glances'
fi

# self-defined
alias cs='echo -ne "\e[5 q"'
# alias cs= "printf '%b' '\e[5;red\a'"
alias fde="fd --no-ignore-vcs"
alias c=clear
# better default
alias sudo='sudo -E' #keep user environment

# tmux
alias td="tmux detach"
alias tl="tmux ls"
alias tn="tmux new -d -t"
alias ta="tmux attach "
alias tnw="tmux new-window -n"
alias tat="ta -t"

# fasd
alias a="fasd -a"
alias d="fasd -d"
alias f="fasd -f"

alias ac="a -B current_folder"
alias ah="a -B home_folder"
alias fc="f -B current_folder"
alias v="f -e nvim"
alias vc= "fc -e nvim"
alias co="f -e code"

alias o="ac -e open"
alias t="ac -e typora"
alias th="ah -e typora"
alias p="ac -e pixea"
alias ph="ah -e pixea"
alias i="a -e iina"
alias ic="ac -e iina"


alias s="fasd -si"
alias sd="s -d"
alias sf="s -f"

alias z="fasd_cd -d"
alias j="z -i"
alias jj="j -B  current_folder"
alias jc="j -b  current_folder"
alias jd="j -b  desk_folder"
alias jh="j -B  home_folder"



#shorthand
alias neo=neofetch # s means system
alias cos=cowsay
alias r=ranger

# cd
setopt autocd
alias ...='cd ../../'
alias less="less -r"

# ls

if command -v exa &> /dev/null; then
  alias l='exa --icons --git --time-style iso'
  alias lt='l -T'
  alias lt2='lt -L2'
  alias lt3='lt -L3'
  alias lt4='lt -L4'
  alias ll='l -lhg --octal-permissions --no-permissions '
  alias llh='ll -H'
  alias lh='llh'
else
  alias l=ls
  alias ll='ls -l'
fi

alias lla='ll -a'
alias la='l -a'
alias lldot='ll -d .*'
alias ldot='l -d .*'


# brew
alias bl='brew leaves'
alias bs='brew search'
alias bsd='brew search --desc'
alias bis='brew install'
alias bisc='brew install --cask'
alias brewup='brew -v update && brew -v upgrade && brew cask upgrade && brew -v cleanup --prune=5 && brew doctor'

alias dud='du -d 1 -h'
alias duf='du -sh *'

# git-fuzzy
alias gcm="git commit --amend"
alias gf="git fuzzy"

alias lg="lazygit"

# forgit
alias fgd="forgit::diff"
alias fga="forgit::add"
alias fgl="forgit::log"
# git
alias ga='git add'
alias gsub='git submodule'
alias g=git
alias gs='git status'
alias gss='git status -s'
alias gc="git commit -v"
alias gca="gc  -a"
alias gcam="gca -m"
alias gcamr="gcam 'regular update'"
alias gb="git branch"
alias gbD="git branch -D"
alias gbd="git branch -d"
alias gba='git branch -a'
alias gco="git checkout"
alias gcb="git checkout -b"
alias gp="git push"
alias gd="git pull"
alias gr="git remote"
alias glg='git log --stat'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glgp='git log --stat -p'
alias glo='git log --oneline --decorate'
alias glod='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'
alias glods='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'' --date=short'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glol='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'
alias glola='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --all'
alias glols='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --stat'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'





# alias rsync-copy="rsync -avz --progress -h"
# alias rsync-move="rsync -avz --progress -h --remove-source-files"
# alias rsync-update="rsync -avzu --progress -h"
# alias rsync-synchronize="rsync -avzu --delete --progress -h"


# alias dl="docker ps -l -q"
# alias dps="docker ps"
# alias dpa="docker ps -a"
# alias di="docker images"
# drm() { docker rm $(docker ps -a -q); } # Remove all containers
# alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'" # Get container IP
# alias dkd="docker run -d -P" # Run deamonized container, e.g., $dkd base /bin/echo hello
# alias dki="docker run -i -t -P" # Run interactive container, e.g., $dki base /bin/bash
# alias dex="docker exec -i -t" # Execute interactive container, e.g., $dex base /bin/bash
# dstop() { docker stop $(docker ps -a -q); } # Stop all containers
# alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)' # Stop and Remove all containers
# dri() { docker rmi $(docker images -q); } # Remove all images
# dbu() { docker build -t=$1 .; } # Dockerfile build, e.g., $dbu tcnksm/test 
# dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }  # Show all alias related docker
# dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; } # Bash into running container







# zsh is able to auto-do some kungfoo
# depends on the SUFFIX :)
# auto open in relative application when file typed.
# 

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'




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
  for ft in $_media_fts; do alias -s $ft='$Player'; done

 
fi

