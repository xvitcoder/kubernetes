#!/bin/bash

kubectl create namespace monitoring

helm install prometheus prometheus-community/prometheus --values prometheus/values.yaml --namespace monitoring
helm install grafana stable/grafana --values grafana/values.yaml --namespace monitoring
