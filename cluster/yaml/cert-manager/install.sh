#!/bin/bash

kubectl create namespace cert-manager
helm install cert-manager jetstack/cert-manager --namespace cert-manager
