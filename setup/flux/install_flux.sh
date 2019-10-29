#!/bin/bash


helm upgrade -i capstone-flux \
     --set helmOperator.create=true \
     --set helmOperator.createCRD=false \
     --set git.url=git@github.com:FlorianSeidel/DevOps_Capstone_Deployment \
     --namespace capstone2 fluxcd/flux
