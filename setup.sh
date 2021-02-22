#!/bin/bash

cd "$HOME" || return

system_type=($uname -s)
if [[ $system_type == "Darwin"]]; then
    echo "Mac it is ! Good choice sir."
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install git
fi

if [[ $system_type == "Linux" ]]; then
    echo "Linux huh ? You better get yourself a coffee sir, with a touch of sugar."
    sudo apt update
    sudo apt install -y git curl wget
fi


cd ~
curl -sfL https://git.io/chezmoi | sh

mkdir -p ~/.ssh
chmod 0700 ~/.ssh

if [ ! -n "$(grep "^github.com " ~/.ssh/known_hosts)" ]; then ssh-keyscan github.com >> ~/.ssh/known_hosts 2>/dev/null; fi

export PATH=$HOME/bin:$PATH

cd ~ 
chezmoi apply
