#!/bin/bash

EKSCTL_EXPERIMENTAL=true \
eksctl install flux  \
        --cluster=capstone-cluster \
        --region=eu-central-1 \
        --git-url=git@github.com:FlorianSeidel/DevOps_Capstone_Deployment.git \
        --git-email=seidel.florian@gmail.com \
        --namespace=kube-system
