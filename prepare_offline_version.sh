#!/usr/bin/env bash

set -ex

password=${1}

ls -ltrh
pwd
#cp -rp inventory/local/hosts.ini kubespray/inventory/local/hosts.ini


pipenv --python 2.7.5 install -r requirements.txt
export ANSIBLE_HOST_KEY_CHECKING=False && \
  pipenv run ansible-playbook -i inventory/local/hosts.ini offline_cache.yml \
    -e 'local_release_dir=./releases' -e '{ download_container: False }' \
    -e '{ skip_downloads: False }' -e ansible_os_family=RedHat 
