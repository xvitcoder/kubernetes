#!/bin/bash

helm install docker-registry stable/docker-registry --values values.yaml --namespace kube-system
