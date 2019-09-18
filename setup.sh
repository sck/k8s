#! /bin/sh

./set_hosts.py
cp ssh.config ~/.ssh/config
ansible-playbook -i hosts ~/kube-cluster/hostname.yml
ansible-playbook -i hosts ~/kube-cluster/initial.yml
ansible-playbook -i hosts ~/kube-cluster/kube-dependencies.yml
ansible-playbook -i hosts ~/kube-cluster/master.yml
ansible-playbook -i hosts ~/kube-cluster/workers.yml
