  PACKAGES_LIST=(
    bat fzf autojump 
  )



# Install brew packages if brew is installed,
# else install brew then packages.
install_brew_package(){
  if  [[ -z "$(command -v brew)" ]]; then
    echo "Brew not found, Installing..."
    brew_install
    brew_change_remote
  fi
  brew install ${PACKAGES_LIST[@]}
}


if [[ "$(uname -s)" == "Linux" ]]; then 
  BREW_TYPE="linuxbrew"
else 
  BREW_TYPE="homebrew"
fi
export REMOTE_URL=https://mirrors.tuna.tsinghua.edu.cn
export HOMEBREW_BREW_GIT_REMOTE="/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="${REMOTE_URL}/git/homebrew/${BREW_TYPE}-core.git"
export HOMEBREW_BOTTLE_DOMAIN="${REMOTE_URL}/${BREW_TYPE}-bottles"



brew_install(){
  git clone --depth=1 ${REMOTE_URL}/git/homebrew/install.git brew-install
  /bin/bash brew-install/install.sh
  rm -rf brew-install

  if [[ $BREW_TYPE == "linuxbrew" ]]; then
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
    test -r ~/.profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile
    test -r ~/.zprofile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zprofile
  fi
}

brew_change_remote(){
  git -C "$(brew --repo)" remote set-url origin $REMOTE_URL/git/homebrew/brew.git
  if [[ $BREW_TYPE == "linuxbrew" ]]; then
    git -C "$(brew --repo homebrew/core)" remote set-url origin $REMOTE_URL/git/homebrew/linuxbrew-core.git
  else
    BREW_TAPS="$(brew tap)"
    for tap in core cask{,-fonts,-drivers,-versions}; do
        if echo "$BREW_TAPS" | grep -qE "^homebrew/${tap}\$"; then
            # 将已有 tap 的上游设置为本镜像并设置 auto update
            # 注：原 auto update 只针对托管在 GitHub 上的上游有效
            git -C "$(brew --repo homebrew/${tap})" remote set-url origin $REMOTE_URL/git/homebrew/homebrew-${tap}.git
            git -C "$(brew --repo homebrew/${tap})" config homebrew.forceautoupdate true
        else   # 在 tap 缺失时自动安装（如不需要请删除此行和下面一行）
            brew tap --force-auto-update homebrew/${tap} $REMOTE_URL/git/homebrew/homebrew-${tap}.git
        fi
    done
  fi
  brew update-reset
}


