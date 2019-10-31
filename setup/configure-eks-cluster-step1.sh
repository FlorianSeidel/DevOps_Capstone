#!/bin/bash
./eks/create-eks-cluster.sh
./setup_helm.sh
./flux/install_flux.sh eks
./helm/add-helm-repo.sh

echo "Please run flux identity to get the deploy key. Use this deploy key for the DevOps_Capstone_Deployment repo."

echo "Clone the DevOps_Capstone_Deployment repository and run create-reg-cred.sh and create-jenkins-secrets.sh.
      To allow Jenkins to push to DockerHub using your local credentials and to read from the DevOps_Capstone_* repos."
