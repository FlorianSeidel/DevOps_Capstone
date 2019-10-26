#!/bin/bash

helm install --name jenkins --namespace capstone2 -f values.yaml stable/jenkins
