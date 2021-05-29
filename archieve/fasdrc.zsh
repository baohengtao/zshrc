_FASD_DATA="$HOME/.data/fasd"
_FASD_NOCASE=0
_FASD_SINK="$HOME/.data/fasd.log"
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
