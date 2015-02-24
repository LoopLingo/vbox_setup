#!/bin/bash

## install the ssh keys
ssh-keygen -b 1024 -t rsa -N "" -f ~/.ssh/looplingo_vbox_ssh
cat ~/.ssh/looplingo_vbox_ssh.pub | ssh ubuntu@192.168.56.2 "mkdir -p ~/.ssh && cat - >> ~/.ssh/authorized_keys"

## install a local directory to contain our files, setup deployment
mkdir -p ~/.looplingo/conf
virtualenv --no-site-packages ~/.looplingo/env
~/.looplingo/env/bin/pip install Fabric boto

## make sure fab is easy to run
echo "alias fab=\"~/.looplingo/env/bin/python ~/.looplingo/env/bin/fab\"" >> ~/.bashrc
