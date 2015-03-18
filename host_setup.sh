#!/bin/bash

## install the ssh keys
if [ ! ~/.ssh/looplingo_vbox_ssh ]
then
  ssh-keygen -b 1024 -t rsa -N "" -f ~/.ssh/looplingo_vbox_ssh
fi
cat ~/.ssh/looplingo_vbox_ssh.pub | ssh ubuntu@192.168.56.2 "mkdir -p ~/.ssh && cat - >> ~/.ssh/authorized_keys"

## install a local directory to contain our files, setup deployment
mkdir -p ~/.looplingo/conf
if [ ! -f ~/.looplingo/env ]
then
  sudo easy_install virtualenv
  virtualenv --no-site-packages ~/.looplingo/env
  ~/.looplingo/env/bin/pip install Fabric boto tabulate
fi

## make sure fab is easy to run
echo "alias fab=\"~/.looplingo/env/bin/python ~/.looplingo/env/bin/fab\"" >> ~/.bashrc
source ~/.bashrc
if [ ! -f ~/.looplingo/conf/fabric_locals.py ]
then
  curl -o ~/.looplingo/conf/fabric_locals.py "https://raw.githubusercontent.com/LoopLingo/vbox_setup/master/fabric_locals.py"
fi

sudo su -c "echo \"if [ \\\"\\\${BASH-no}\\\" != \\\"no\\\" ]; then [ -r ~/.bashrc ] && source ~/.bashrc; fi\" >> /etc/profile"
sudo su -c "echo \"192.168.56.2 local-dev.lingopoints.com\" >> /etc/hosts"
