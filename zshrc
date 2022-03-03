PATH=$MYPATH
autoload -U colors && colors
source  "$ZDOTDIR/main/init.zsh"

# environment export

if [ $(command -v virtualenvwrapper.sh) ]; then
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
  export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
  source virtualenvwrapper.sh
fi


# PYENV
export PATH="/Users/htao/.local/pyenv/shims:${PATH}"
export PYENV_SHELL=zsh
source "$PYENV_ROOT/libexec/../completions/pyenv.zsh"
command pyenv rehash 2>/dev/null
pyenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  activate|deactivate|rehash|shell)
    eval "$(pyenv "sh-$command" "$@")";;
  *)
    command pyenv "$command" "$@";;
  esac
}


# # PYENV VIRTUALENV
export PATH="$HOME/.local/pyenv/plugins/pyenv-virtualenv/shims:${PATH}";
export PYENV_VIRTUALENV_INIT=1;
_pyenv_virtualenv_hook() {
  local ret=$?
  if [ -n "$VIRTUAL_ENV" ]; then
    eval "$(pyenv sh-activate --quiet || pyenv sh-deactivate --quiet || true)" || true
  else
    eval "$(pyenv sh-activate --quiet || true)" || true
  fi
  return $ret
};
typeset -g -a precmd_functions
if [[ -z $precmd_functions[(r)_pyenv_virtualenv_hook] ]]; then
  precmd_functions=(_pyenv_virtualenv_hook $precmd_functions);
fi

