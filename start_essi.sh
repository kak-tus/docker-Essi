#!/usr/bin/env sh

userdel www-data 2>/dev/null
groupdel www-data 2>/dev/null
groupadd -g $USER_GID www-data
useradd -d /home/www-data -g www-data -u $USER_UID www-data

mkdir -p $ESSI_DEB_PATH
chown -R www-data:www-data $ESSI_DEB_PATH

hypnotoad -f /usr/local/bin/essi.pl
