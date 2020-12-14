#!/bin/bash


helm uninstall prometheus --namespace monitoring
helm uninstall grafana --namespace monitoring

kubectl delete namespace monitoring
