#!/bin/bash

echo 'Step 1: Create cluster'
eksctl create cluster \
    --name cloud-native-cluster \
    --region eu-central-1 \
    --nodes-max 5 \
    --managed
    
echo 'Step 2: Create OIDC provider'
eksctl utils associate-iam-oidc-provider \
    --region eu-central-1 \
    --cluster cloud-native-cluster \
    --approve

echo 'Step 3: already manually done'
echo 'Step 4: already manually done'

echo 'Step 5: Create service account'
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.8/docs/examples/rbac-role.yaml

echo 'Step 6: Create IAM role'
eksctl create iamserviceaccount \
    --region eu-central-1 \
    --name alb-ingress-controller \
    --namespace kube-system \
    --cluster cloud-native-cluster \
    --attach-policy-arn arn:aws:iam::733293604736:policy/ALBIngressControllerIAMPolicy \
    --override-existing-serviceaccounts \
    --approve
    
kubectl apply -f alb-ingress-controller.yaml

echo '>> IMPORTANT <<'
echo 'If something went wring, read documentation under https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html'
