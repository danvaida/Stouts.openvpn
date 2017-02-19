#!/bin/bash

printenv
ansible --version
cd /etc/ansible/roles/openvpn/tests

[ -z "$test_case" ] && export test_case='' || EXTRA_VARS="--extra-vars @./test_case_$test_case.yml"

set -e

echo "Checking for syntax errors..."
ansible-playbook test.yml --syntax-check

echo "Checking dry-run mode compatibiltiy..."
ansible-playbook test.yml $EXTRA_VARS --diff --check

ansible-playbook test.yml $EXTRA_VARS -vv

echo "Running a second time to verify idempotence..."
set +e
ansible-playbook test.yml $EXTRA_VARS > /tmp/second_run.log
{
    tail -n 5 /tmp/second_run.log | grep 'changed=0' &&
    echo 'Playbook is idempotent.'
} || {
    cat /tmp/second_run.log
    echo 'Playbook is **NOT** idempotent.'
    exit 1
}
