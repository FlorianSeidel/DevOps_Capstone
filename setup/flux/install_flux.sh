#!/bin/bash

helm repo add fluxcd https://charts.fluxcd.io

kubectl apply -f https://raw.githubusercontent.com/fluxcd/flux/helm-0.10.1/deploy-helm/flux-helm-release-crd.yaml

helm upgrade -i capstone-flux \
     --set helmOperator.create=true \
     --set helmOperator.createCRD=false \
     --set git.url=git@github.com:FlorianSeidel/DevOps_Capstone_Deployment \
     --set git.branch=$1 \
     --namespace flux fluxcd/flux

export FLUX_FORWARD_NAMESPACE=flux

fluxctl sync