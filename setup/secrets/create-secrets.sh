#!/bin/bash

kubectl apply -f capstone-github-pw-secret.yaml -n capstone2
kubectl apply -f capstone-dockerhub-pw-secret.yaml -n capstone2
kubectl apply -f capstone-github-token-secret.yaml -n capstone2