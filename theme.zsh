
prompt_theme_list=(
  dracula/zsh
  denysdovhan/spaceship-prompt
  sindresorhus/pure
)
THEME_CODE=${THEME_CODE:-Dracula}
THEME_PROMPT=${THEME_PROMPT:-sindresorhus/pure}

if [[ THEME_PROMPT == denysdovhan/spaceship-prompt ]]; then
  SPACESHIP_TIME_SHOW=false
  SPACESHIP_USER_SHOW=false
  SPACESHIP_HOST_SHOW=false
  SPACESHIP_DIR_TRUNC=0
  SPACESHIP_DIR_TRUNC_REPO=false
fi

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
fi


