#!/usr/bin/env bash

# foundation: brew, webi, git, zsh, oh-my-zsh, ghostty, tmux, neovim, aerospace
# ci/cd: gh, act
# iac: terraform, terragrunt, tfenv
# containers: colima, k9s, kind/minikube, argocd
# programming: python3, golang
# cloud: aws-cli, awsless, eksctl
# misc: ripgrep, fd, pathman, aliasman, lsd, curlie, jq, yq, shellcheck, shfmt

setup_zsh() {
    brew install zsh && chsh -s $(which zsh); zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_with_brew () {
    # make these better, how ?
    brew tap hashicorp/tap && brew install hashicorp/tap/terraform
    brew tap weaveworks/tap && brew install weaveworks/tap/eksctl
    brew install --cask nikitabobko/tap/aerospace

    local foudation="ghostty, tmux, neovim, gh, act, opentofu, terragrunt,
    tfenv, colima, k9s, kind, argocd"
    for k in $foudation; do
        if brew info --cask "$k" &>/dev/null; then
            brew install --cask $k
        elif brew info "$k" &>/dev/null; then
            brew install $k
        else
            echo "package doesn't exists"
        fi
    done
}

install_with_webi(){
    local misc="brew, git, webi, ripgrep, fd, pathman, aliasman, lsd,
    curlie, jq, yq, shellcheck, shfmt, awsless"
    set -e
    for i in $misc; do
        echo "Installing $i"
        curl -sS https://webi.sh/$i | sh
        if [ $? -ne 0 ]; then
            trap 'echo "exit $? due to error"' EXIT
        fi
        echo "Sourcing $i"
        source ~/.config/envman/PATH.env
    done
}

install_with_webi
#install_with_brew()
#setup_zsh()
