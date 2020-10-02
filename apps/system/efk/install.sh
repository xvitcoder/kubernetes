#!/bin/bash

kubectl create namespace kube-logging

helm install elasticsearch  elastic/elasticsearch   --values elasticsearch/values.yaml  --namespace kube-logging
helm install kibana         elastic/kibana          --values kibana/values.yaml         --namespace kube-logging

kubectl apply -f fluentd/fluent-bit-config.yaml
helm install fluentd        stable/fluent-bit       --values fluentd/values.yaml        --namespace kube-logging


