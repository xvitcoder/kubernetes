#!/bin/bash

kubectl create namespace cicd

helm install jenkins jenkinsci/jenkins --values `dirname $0`/values.yaml --namespace cicd
