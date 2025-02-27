#!/usr/bin/env bash


# foundation: brew, webi, git, zsh, oh-my-zsh, ghostty, tmux, neovim, aerospace
# ci/cd: gh, act
# iac: terraform, terragrunt, tfenv
# containers: colima, k9s, kind/minikube
# programming: python3, golang
# cloud: aws-cli, awsless, eksctl
# misc: ripgrep, fd, pathman, aliasman, lsd, curlie, jq, yq, shellcheck, shfmt


misc="brew, webi, ripgrep, fd, pathman, aliasman, lsd, curlie, jq, yq, shellcheck, shfmt"
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
