#!/bin/bash

kubectl apply -f capstone-github-pw-secret.yaml -n capstone2
kubectl apply -f capstone-dockerhub-pw-secret.yaml -n capstone2
helm install --name jenkins --namespace capstone2 -f values.yaml stable/jenkins
