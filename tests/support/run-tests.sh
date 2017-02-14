#!/bin/bash

printenv
ansible --version
cd /etc/ansible/roles/openvpn/tests

set -e

echo "Checking dry-run mode compatibiltiy..."
ansible-playbook test.yml --diff --check

ansible-playbook test.yml -vv

echo "Running a second time to verify idempotence..."
set +e
ansible-playbook test.yml > /tmp/second_run.log
{
    tail -n 5 /tmp/second_run.log | grep 'changed=0' &&
    echo 'Playbook is idempotent.'
} || {
    cat /tmp/second_run.log
    echo 'Playbook is **NOT** idempotent.'
    exit 1
}
