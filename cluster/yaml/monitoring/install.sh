#!/bin/bash

kubectl create namespace monitoring

helm install prometheus prometheus-community/prometheus --values `dirname $0`/prometheus/values.yaml --namespace monitoring
helm install grafana grafana/grafana --values `dirname $0`/grafana/values.yaml --namespace monitoring
