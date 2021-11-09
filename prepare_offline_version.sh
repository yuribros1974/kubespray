#!/usr/bin/env bash

set -ex
git submodule update --init --recursive
pwd
ls -ltrh
mv kubespray/* .
cp -rp  igz-install/* .
cat inventory/local/hosts.ini

password=${1}


mkdir -p releases

chmod 777 releases

pipenv --python 2.7.5 install -r requirements.txt
export ANSIBLE_HOST_KEY_CHECKING=False && \
  pipenv run ansible-playbook -i inventory/local/hosts.ini offline_cache.yml \
    -e 'local_release_dir=./releases' -e '{ download_container: False }' \
    -e '{ skip_downloads: False }' -e ansible_os_family=RedHat
