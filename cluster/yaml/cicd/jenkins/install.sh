#!/bin/bash

kubectl create namespace cicd

helm install jenkins jenkinsci/jenkins --values values.yaml --namespace cicd
