#!/bin/bash

kubectl config use-context $1
kubectl get secret -n capstone-adm  -l sealedsecrets.bitnami.com/sealed-secrets-key=active -o yaml --export > sealed-secrets-key.yaml

kubectl config use-context $2


kubectl delete secret -n capstone-adm \
        "$(kubectl get secret -n capstone-adm  -l sealedsecrets.bitnami.com/sealed-secrets-key=active -o jsonpath='{.items..metadata.name}')"

kubectl apply -f sealed-secrets-key.yaml
#rm sealed-secrets-key.yaml
kubectl delete pod -n capstone-adm -l app=sealed-secrets