# where do you want to store your plugins?
ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

# get zsh_unplugged and store it with your other plugins
if [[ ! -d $ZPLUGINDIR/zsh_unplugged ]]; then
  git clone --quiet https://github.com/mattmc3/zsh_unplugged $ZPLUGINDIR/zsh_unplugged
fi
source $ZPLUGINDIR/zsh_unplugged/zsh_unplugged.plugin.zsh

# make list of the Zsh plugins you use
repos=(
  romkatv/powerlevel10k
  zdharma/fast-syntax-highlighting
  zsh-users/zsh-history-substring-search
  # bigH/git-fuzzy
	wfxr/forgit
	djui/alias-tips
	changyuheng/zsh-interactive-cd
	Aloxaf/fzf-tab
	zsh-users/zsh-autosuggestions
	zsh-users/zsh-completions
	jeffreytse/zsh-vi-mode.git
	wookayin/fzf-fasd

)

# now load your plugins
plugin-load $repos
# for plugin zsh-history-substring-search
bindkey  '^K' history-substring-search-up
bindkey  '^J' history-substring-search-down
# alias-tips.plugin
export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1
eval "$(fasd --init auto)"
THEME_CODE=Dracula

