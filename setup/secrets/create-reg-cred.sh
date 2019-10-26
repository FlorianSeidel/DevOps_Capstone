#/bin/bash.sh
#Run this to create the docker login credentials secret
#This is needed so that kubernetes can pull the build slave images for jenkins
kubectl create secret generic regcred --namespace capstone2  --from-file=.dockerconfigjson=/home/seifl/.docker/config.json --type=kubernetes.io/dockerconfigjson
