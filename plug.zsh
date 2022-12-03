# where do you want to store your plugins?
ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

# get zsh_unplugged and store it with your other plugins
if [[ ! -d $ZPLUGINDIR/zsh_unplugged ]]; then
  git clone --quiet https://github.com/mattmc3/zsh_unplugged $ZPLUGINDIR/zsh_unplugged
fi
source $ZPLUGINDIR/zsh_unplugged/zsh_unplugged.zsh

# make list of the Zsh plugins you use
# fzf-tab must before plugins which will wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting!!
repos=(
  romkatv/powerlevel10k
  Aloxaf/fzf-tab
  zdharma/fast-syntax-highlighting
  zsh-users/zsh-history-substring-search
  # bigH/git-fuzzy
	wfxr/forgit
	djui/alias-tips
	changyuheng/zsh-interactive-cd
	zsh-users/zsh-autosuggestions
	zsh-users/zsh-completions
	# jeffreytse/zsh-vi-mode.git
	wookayin/fzf-fasd
  ael-code/zsh-colored-man-pages
)

# now load your plugins
plugin-load $repos
# for plugin zsh-history-substring-search
bindkey  '^K' history-substring-search-up
bindkey  '^J' history-substring-search-down
# alias-tips.plugin
export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1

# zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
eval "$(fasd --init auto)"
THEME_CODE=Dracula




function plugin-update {
  ZPLUGINDIR=${ZPLUGINDIR:-$HOME/.config/zsh/plugins}
  for d in $ZPLUGINDIR/*/.git(/); do
    echo "Updating ${d:h:t}..."
    command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
  done
}

function plugin-ls {
  for d in $ZPLUGINDIR/*/.git; do
    git -C "${d:h}" remote get-url origin
  done
}
