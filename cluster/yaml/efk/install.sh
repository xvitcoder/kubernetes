#!/bin/bash

kubectl create namespace kube-logging

helm install elasticsearch elastic/elasticsearch --values `dirname $0`/elasticsearch/values.yaml --namespace kube-logging
helm install kibana elastic/kibana --values `dirname $0`/kibana/values.yaml --namespace kube-logging

kubectl apply -f `dirname $0`/fluentd/fluent-bit-config.yaml

helm install fluentd stable/fluent-bit --values `dirname $0`/fluentd/values.yaml --namespace kube-logging


