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

cp misc/notion /usr/local/bin/notion
sed -i "s:HOME:$HOME:g" /usr/local/bin/notion

if ! which composer > /dev/null; then
    EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
    then
        >&2 echo 'ERROR: Invalid installer signature'
        rm composer-setup.php
        exit 1
    fi

    php composer-setup.php --quiet
    rm composer-setup.php

    mv composer.phar /usr/local/bin/composer
fi

composer g require psy/psysh:@stable

cp -R powerline/ ~/.config/powerline

echo "All set! To finish install, run 'chsh -s /bin/zsh'!"