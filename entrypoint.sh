#!/usr/bin/bash

export ANSIBLE_NOCOLOR=1
export ANSIBLE_NOCOWS=1

set -e

if test ! -z "$TZ"
then
    ln -sf ../usr/share/zoneinfo/$TZ /etc/localtime
fi

. /etc/sysconfig/sshd

pushd /etc/ansible
ansible-playbook sftp.yml
popd

echo "Starting sshd!"

exec /usr/sbin/sshd -D -e $OPTIONS
