#!/bin/bash


helm uninstall elasticsearch --namespace kube-logging
helm uninstall kibana --namespace kube-logging
helm uninstall fluentd --namespace kube-logging

kubectl delete namespace kube-logging
