#!/bin/sh

# If in vagrant, install the notion command
if grep -q '^vagrant:' /etc/passwd; then
    if ! which php > /dev/null; then
        echo 'ERROR: PHP is required. Please install and try again'
        exit 1
    fi

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
    cp misc/notion /usr/local/bin/notion

    sed -i "s:HOME:$HOME:g" /usr/local/bin/notion
fi