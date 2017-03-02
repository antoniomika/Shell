#!/bin/sh

# Get the platform
unamestr=`uname`

# Dependency checks
if ! which python > /dev/null; then
    echo 'ERROR: Python is required. Please install and try again'
    exit 1
else
    if ! which pip > /dev/null; then
        echo 'ERROR: pip is required. Installing now'
        sudo easy_install pip
    fi
fi

if ! which git > /dev/null; then
    echo 'ERROR: Git is required. Please install and try again'
    exit 1
fi

# Get oh-my-zsh and zsh syntax highlighting
if [ ! -d "~/.oh-my-zsh/" ]; then
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

if [ ! -d "~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

# Install powerline
pip install --upgrade pip
pip install --user powerline-status
pip install --user powerline-gitstatus

# Setup zshrc
if [ ! -f "~/.zshrc" ]; then
    cp .zshrc ~/.zshrc
    POWERLINE_LOCATION=$(pip show powerline-status | grep -i "Location: " | awk '{print $2}')

    if [[ "$unamestr" == 'Linux' ]]; then
        sed -i "s/PIP_REPO_ROOT/$POWERLINE_LOCATION/g" ~/.zshrc
    elif [[ "$unamestr" == 'Darwin' ]]; then
        sed -i .bak "s/PIP_REPO_ROOT/$POWERLINE_LOCATION/g" ~/.zshrc
    fi
fi

# Setup the necessary configs
mkdir -p ~/.logs/
mkdir -p ~/.config/

if [ ! -d "~/.config/powerline" ]; then
    cp -R powerline/ ~/.config/powerline
fi

echo "All set! To finish install, run 'chsh -s /bin/zsh'!"