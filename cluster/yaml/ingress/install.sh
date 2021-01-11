#!/bin/bash

helm install ingress ingress-nginx/ingress-nginx --values `dirname $0`/values.yaml --namespace kube-system
