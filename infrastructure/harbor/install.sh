#!/bin/bash

echo 'Step 1: add repo'
helm repo add bitnami https://charts.bitnami.com/bitnami

echo 'Step 2: create namespace'
kubectl create ns harbor

echo 'Step 3: install chart'
helm install harbor bitnami/harbor \
    --version 7.1.1 \
    -f values.yaml \
    -n harbor
