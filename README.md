# k8s_provision_terraform

We can use this terraform playbook to create k8s cluster on AWS.It will create cluster on existing VPC and will use default Security Group, these details we can provide in variable file. To create cluster terraform needs aws account with IAM, S3 and ec2-instance create and get policy access. terraform will also create a role for cluster nodes to push data on S3.

Its just a small contribution we can do lots of things to make this project to more flexible for entire new infra like creating new VPC and separate hosted zone for k8s cluster. 

# keep learning !!

To deploy helm

https://www.digitalocean.com/community/tutorials/how-to-install-software-on-kubernetes-clusters-with-the-helm-2-package-manager

prometheus-operator

https://github.com/helm/charts/tree/master/stable/prometheus-operator
