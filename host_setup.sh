#!/bin/bash

## install the ssh keys
ssh-keygen -b 1024 -t rsa -N "" -f ~/.ssh/looplingo_vbox_ssh
cat ~/.ssh/looplingo_vbox_ssh.pub | ssh ubuntu@192.168.56.2 "mkdir -p ~/.ssh && cat - >> ~/.ssh/authorized_keys"

## install a local directory to contain our files, setup deployment
mkdir -p ~/.looplingo/conf
sudo easy_install virtualenv
virtualenv --no-site-packages ~/.looplingo/env
~/.looplingo/env/bin/pip install Fabric boto tabulate

## make sure fab is easy to run
echo "alias fab=\"~/.looplingo/env/bin/python ~/.looplingo/env/bin/fab\"" >> ~/.bashrc
source ~/.bashrc
curl -o ~/.looplingo/conf/fabric_locals.py "https://raw.githubusercontent.com/LoopLingo/vbox_setup/master/fabric_locals.py"

sudo -s "echo \"if [ \\\"\\\${BASH-no}\\\" != \\\"no\\\" ]; then [ -r ~/.bashrc ] && source ~/.bashrc; fi\" >> /etc/profile"
sudo -s "echo \"192.168.56.2 local-dev.lingopoints.com\" >> /etc/hosts"
