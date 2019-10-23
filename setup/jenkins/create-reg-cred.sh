#/bin/bash.sh
#Run this to create the docker login credentials secret
kubectl create secret generic regcred --namespace capstone  --from-file=.dockerconfigjson=/home/seifl/.docker/config.json --type=kubernetes.io/dockerconfigjson
