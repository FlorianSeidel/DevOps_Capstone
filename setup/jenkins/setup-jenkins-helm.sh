#!/bin/bash

helm install --name jenkins --namespace capstone-cicd -f values.yaml stable/jenkins
