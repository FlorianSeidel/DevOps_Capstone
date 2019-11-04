#!/bin/bash
GH_USER=$1
GH_PASS=$2
GH_TOKEN=$3
DH_USER=$4
DH_PASS=$5

#Create secrets necessary for jenkins
kubeseal --fetch-cert \
--controller-namespace=capstone-adm \
--controller-name=sealed-secrets \
> pub-cert.pem

kubectl create secret docker-registry regcred --dry-run --docker-username=florianseidel --docker-password=test -o yaml

kubectl create secret docker-registry regcred \
	--namespace capstone-build  \
	--docker-username=$DH_USER --docker-password=$DH_PASS \
	--dry-run \
	-o json > reg-cred.json

kubeseal --format=yaml --cert=pub-cert.pem < reg-cred.json > releases/capstone-build/reg-cred.yaml

rm reg-cred.json
cat releases/capstone-build/reg-cred.yaml

git add releases/capstone-build/reg-cred.yaml

kubectl -n capstone-build create secret generic jenkins-secret \
        --from-literal=GITHUB_USER=$GH_USER \
        --from-literal=GITHUB_PW=$GH_PASS \
        --from-literal=GITHUB_TOKEN=$GH_TOKEN \
        --from-literal=DOCKERHUB_USER=$DH_USER \
        --from-literal=DOCKERHUB_PW=$DH_PASS \
        --dry-run \
        -o json > jenkins-secret.json

kubeseal --format=yaml \
         --cert=pub-cert.pem \
         < jenkins-secret.json \
         > releases/capstone-build/jenkins-secret.yaml

rm jenkins-secret.json
rm pub-cert.pem

git add releases/capstone-build/jenkins-secret.yaml
git commit -m "Add Jenkins password secret"
git push


kubeseal --fetch-cert \
--controller-namespace=capstone-adm \
--controller-name=sealed-secrets \
> pub-cert.pem

kubectl create secret docker-registry regcred \
	--namespace capstone-dev  \
	--docker-username=$DH_USER --docker-password=$DH_PASS \
	--dry-run \
	-o json > reg-cred.json
kubeseal --format=yaml --cert=pub-cert.pem < reg-cred.json > releases/capstone-dev/reg-cred.yaml
rm reg-cred.json
cat releases/capstone-dev/reg-cred.yaml
git add releases/capstone-dev/reg-cred.yaml

kubectl create secret docker-registry regcred \
	--namespace capstone-stag  \
	--docker-username=$DH_USER --docker-password=$DH_PASS \
	--dry-run \
	-o json > reg-cred.json
kubeseal --format=yaml --cert=pub-cert.pem < reg-cred.json > releases/capstone-stag/reg-cred.yaml
rm reg-cred.json
cat releases/capstone-stag/reg-cred.yaml
git add releases/capstone-stag/reg-cred.yaml


kubectl create secret docker-registry regcred \
	--namespace capstone-prod-blue  \
	--docker-username=$DH_USER --docker-password=$DH_PASS \
	--dry-run \
	-o json > reg-cred.json
kubeseal --format=yaml --cert=pub-cert.pem < reg-cred.json > releases/capstone-prod-blue/reg-cred.yaml
rm reg-cred.json
cat releases/capstone-prod-blue/reg-cred.yaml
git add releases/capstone-prod-blue/reg-cred.yaml

kubectl create secret docker-registry regcred \
	--namespace capstone-prod-green  \
	--docker-username=$DH_USER --docker-password=$DH_PASS \
	--dry-run \
	-o json > reg-cred.json
kubeseal --format=yaml --cert=pub-cert.pem < reg-cred.json > releases/capstone-prod-green/reg-cred.yaml
rm reg-cred.json
cat releases/capstone-prod-green/reg-cred.yaml
git add releases/capstone-prod-green/reg-cred.yaml

git commit -a -m "Add docker registry credentials." && git push
