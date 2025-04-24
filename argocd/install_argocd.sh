#!/usr/bin/env bash

helm install argocd-demo argo/argo-cd -f argocd-custom-values.yaml -n argocd --create-namespace

kubectl port-forward service/argocd-demo-server -n argocd 8080:443 & PF_PID=$!

echo "Waiting for port-forward to be ready..."
while ! nc -z localhost 8080; do
  sleep 0.5
done

echo "Port-forward started. PID: $PF_PID"

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
