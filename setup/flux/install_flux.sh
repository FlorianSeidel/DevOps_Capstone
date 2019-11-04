#!/bin/bash
GH_USER=$1
GH_PASS=$2
GH_TOKEN=$3
DEPLOYMENT_REPO=$4
BRANCH=$5
CLUSTER_NAME=$6
DH_USER=$7
DH_PASS=$8

helm repo add fluxcd https://charts.fluxcd.io

kubectl apply -f https://raw.githubusercontent.com/fluxcd/flux/helm-0.10.1/deploy-helm/flux-helm-release-crd.yaml

helm upgrade -i ${CLUSTER_NAME}-flux \
     --set helmOperator.create=true \
     --set helmOperator.createCRD=false \
     --set git.url=git@github.com:$GH_USER/$DEPLOYMENT_REPO \
     --set git.branch=$BRANCH \
     --namespace flux fluxcd/flux

export FLUX_FORWARD_NAMESPACE=flux

curl --netrc-file <(cat <<<"machine api.github.com login $GH_USER password $GH_PASS") \
     -d '{"title": "Flux Identity for EKS cluster '"$CLUSTER_NAME"' '"$(uuidgen)"'","key": "'"$(fluxctl identity)"'", "read_only": true}' \
     -H "Content-Type: application/json" \
     -X POST https://api.github.com//repos/$GH_USER/$DEPLOYMENT_REPO/keys

#Wait for sealed-secrets container to be running
echo "Waiting for sealed-secrets container to be ready..."
kubectl wait --for condition=ready pod -l app.kubernetes.io/instance=sealed-secrets --timeout=120s -A

path="${0%/*}"
./$path/create-secrets.sh $GH_USER $GH_PASS $GH_TOKEN $DH_USER $DH_PASS

