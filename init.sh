#!/bin/sh

if [ ! -d "~/.oh-my-zsh/" ]; then
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

if [ ! -d "~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

pip install --upgrade pip
pip install --user powerline-status
pip install --user powerline-gitstatus

if [ ! -f "~/.zshrc" ]; then
    cp .zshrc ~/.zshrc
    POWERLINE_LOCATION=$(pip show powerline-status | grep -i "Location: " | awk '{print $2}')

    sed -i "s:PIP_REPO_ROOT:$POWERLINE_LOCATION:g" ~/.zshrc
fi

mkdir -p ~/.logs/
mkdir -p ~/.config/

cp -R powerline/ ~/.config/powerline

echo "All set! To finish install, run 'chsh -s /bin/zsh'!"