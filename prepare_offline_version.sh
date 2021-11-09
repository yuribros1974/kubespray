#!/usr/bin/env bash

set -ex
git submodule update --init --recursive
pwd
ls -ltrh
mv kubespray/* .
cp -rp  igz-install/* .
cat inventory/local/hosts.ini
hostname -I

whoami
ls -ltrh inventory/local/
password=${1}

pipenv --python 2.7.5 install -r requirements.txt
export ANSIBLE_HOST_KEY_CHECKING=False && \
  pipenv run ansible-playbook -i inventory/local/hosts.ini offline_cache.yml \
    -e 'local_release_dir=./releases' -e '{ download_container: False }' \
    -e '{ skip_downloads: False }' -e ansible_os_family=RedHat

#
#password=${1}
#
#mkdir -p "${WORKSPACE}/releases"
#
#pipenv --python 2.7.5 install -r requirements.txt
#export ANSIBLE_HOST_KEY_CHECKING=False && \
#  pipenv run ansible-playbook -i inventory/local/hosts.ini offline_cache.yml \
#    -e "local_release_dir=${WORKSPACE}/releases" -e '{ download_container: False }' \
#    -e '{ skip_downloads: False }' -e ansible_os_family=RedHat
