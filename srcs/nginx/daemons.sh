#!/bin/sh

while true; do
    if [ -z "$(pgrep '/usr/sbin/sshd -D')"]; then
        /usr/sbin/sshd -D &
    fi
    if [ -z "$(pgrep 'nginx -g daemon off;')"]; then
        nginx -g "daemon off;" &
    fi
    sleep 2
done