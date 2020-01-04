#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y apt-transport-https
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker.io
sudo apt-get install -y kubelet=1.15.5-00 kubeadm=1.15.5-00 kubernetes-cni=0.7.5-00
sudo apt-get install -y awscli
sudo mkdir -p /root/.aws/; sudo touch /root/.aws/config
echo -e "[default]\nregion = ap-south-1" | sudo tee -a /root/.aws/config > /dev/null
sudo aws s3 cp s3://k8s-join-master/kubeadm_join.sh /tmp/kubeadm_join.sh
sudo sed -i 's/\\//g' /tmp/kubeadm_join.sh
kubejoin=`cat /tmp/kubeadm_join.sh`
sudo $kubejoin
