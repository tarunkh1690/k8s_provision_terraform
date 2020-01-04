#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y apt-transport-https
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list > /dev/null
#apt-cache showpkg kubelet
sudo apt-get update -y
sudo apt-get install -y docker.io
sudo apt-get install -y kubelet=1.15.5-00 kubeadm=1.15.5-00 kubectl=1.15.5-00 kubernetes-cni=0.7.5-00
sudo kubeadm init --ignore-preflight-errors=NumCPU >> /tmp/kubeadminit.log
sudo cat /tmp/kubeadminit.log | tail -n2 > /tmp/kubeadm_join.sh
sudo apt-get install -y awscli
sudo mkdir -p /root/.aws/; sudo touch /root/.aws/config
echo -e "[default]\nregion = ap-south-1" | sudo tee -a /root/.aws/config > /dev/null
sudo aws s3 cp /tmp/kubeadm_join.sh s3://k8s-join-master/

# kubectl configuration
#sudo mkdir -p $HOME/.kube
#sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config
#sudo sysctl net.bridge.bridge-nf-call-iptables=1
#sleep 120
#export kubever=$(kubectl version | base64 | tr -d '\n') | sudo tee -a /tmp/output > /dev/null
#kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(cat /tmp/output)"
