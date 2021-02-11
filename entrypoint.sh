#!/usr/bin/bash

export ANSIBLE_NOCOLOR=1
export ANSIBLE_NOCOWS=1

set -e

# stolen from https://superuser.com/questions/878640/unix-script-wait-until-a-file-exists

wait_file() {
  local file="$1"; shift
  local wait_seconds="${1:-10}"; shift # 10 seconds as default timeout

  until test $((wait_seconds--)) -eq 0 -o -e "$file"
  do
    echo "Waiting for $file to show up..."
    sleep 1
  done

  ((++wait_seconds))
}

if test ! -z "$TZ"
then
    ln -sf ../usr/share/zoneinfo/$TZ /etc/localtime
fi

wait_file /log/log 30 || {
    echo "/log/log not found!"
    exit 1
}

echo "/log/log is ready!"

ln -s ../log/log /dev/log

. /etc/sysconfig/sshd

pushd /etc/ansible
ansible-playbook sftp.yml
popd

echo "Starting sshd!"

exec /usr/sbin/sshd -D $OPTIONS
