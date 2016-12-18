#!/usr/bin/env sh

userdel www-data 2>/dev/null
groupdel www-data 2>/dev/null
groupadd -g $USER_GID www-data
useradd -d /home/www-data -g www-data -u $USER_UID www-data

mkdir -p $ESSI_DEB_PATH
chown -R www-data:www-data $ESSI_DEB_PATH

mkdir -p /var/cache/apt/apt-file
chown -R www-data:www-data /var/cache/apt/apt-file

chown -R www-data:www-data /home/www-data
export HOME=/home/www-data

hypnotoad -f /usr/local/bin/essi.pl >/proc/1/fd/1 2>/proc/1/fd/2 &
child=$!

trap "kill $child" TERM
wait "$child"
