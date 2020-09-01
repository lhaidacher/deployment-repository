#!/bin/bash

echo 'Step 1: create namespace'
kubectl create namespace argocd

echo 'Step 2: install ArgoCD'
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo 'Step 3: install Ingress'
kubectl apply -f ingress.yaml
