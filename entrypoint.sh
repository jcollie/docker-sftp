#!/usr/bin/bash

set -e

. /etc/crypto-policies/back-ends/opensshserver.config
. /etc/sysconfig/sshd

pushd /etc/ansible
ansible-playbook sftp.yml
popd

exec /usr/sbin/sshd -D -e $OPTIONS $CRYPTO_POLICY
