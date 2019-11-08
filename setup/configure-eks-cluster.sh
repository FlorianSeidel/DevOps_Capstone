#!/bin/bash
set -e
set -u
set -o xtrace

GH_USER=$1
GH_PASS=$2
GH_TOKEN=$3
DH_USER=$4
DH_PASS=$5


./eks/create-eks-cluster.sh
./helm/setup_helm.sh
./flux/install_flux.sh $GH_USER $GH_PASS $GH_TOKEN DevOps_Capstone_Deployment eks capstone $DH_USER $DH_PASS
./helm/add-helm-repo.sh
