#!/bin/bash

helm install ingress ingress-nginx/ingress-nginx --values values.yaml --namespace kube-system
