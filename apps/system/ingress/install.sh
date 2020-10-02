#!/bin/bash

helm install ingress stable/nginx-ingress --values values.yaml --namespace kube-system
