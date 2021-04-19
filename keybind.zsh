

bindkey '^i' autosuggest-accept # for zsh-autosuggestions
bindkey '^k' history-substring-search-up
bindkey '^j' history-substring-search-down



# copy the active line from the command line buffer with "^O"
# onto the system clipboard

copybuffer () {
  if which clipcopy &>/dev/null; then
    printf "%s" "$BUFFER" | clipcopy
  else
    echo "clipcopy function not found. Please make sure you have Oh My Zsh installed correctly."
  fi
}
bindkey "^O" copybuffer


