#/bin/bash.sh
#Run this to create the docker login credentials secret
#This is needed so that kubernetes can pull the build slave images for jenkins
#Secret is encrypted using bitnami sealed-secrets.
#Install sealed secrets first, using helm chart or flux, then get the 
#public certificate. 
kubectl create secret generic regcred \
	--namespace capstone-dev  \
	--from-file=.dockerconfigjson=/home/seifl/.docker/config.json \ 
	--type=kubernetes.io/dockerconfigjson \
	--dry-run \
	-o json > secret.json

kubeseal --format=yaml --cert=pub-cert.pem < secret.json > secret.yaml

rm secret.json

