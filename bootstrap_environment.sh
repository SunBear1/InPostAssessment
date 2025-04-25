#!/usr/bin/env bash
set -e

DEV_CLUSTER_NAME="dev-global-cluster-0"
PROD_CLUSTER_NAME="prd-global-cluster-5"

printf "[STEP 1] Start kubernetes clusters\n"
minikube start -p "${DEV_CLUSTER_NAME}" --driver docker
minikube start -p "${PROD_CLUSTER_NAME}"  --driver docker

printf "\n[STEP 2] Deploying Argo CD via Helm on %s cluster\n" "${DEV_CLUSTER_NAME}"
kubectl config use-context "${DEV_CLUSTER_NAME}"
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm upgrade --install argocd argo/argo-cd --namespace argocd --values ./argocd/values.yaml --create-namespace

printf "Waiting for Argo CD server to become ready...\n"
kubectl rollout status deployment argocd-server -n argocd

printf "Port-forwarding Argo CD UI on localhost:8080...\n"
kubectl port-forward svc/argocd-server -n argocd 8080:443 >/dev/null 2>&1 &
port_forward_pid=$!
printf "\nPort Forward running on PID %s" "${port_forward_pid}"
sleep 5

printf "\n[STEP 3] : Logging into Argo CD CLI...\n"
argocd_password=$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d)
argocd login localhost:8080 --insecure --username admin --password "${argocd_password}"

printf "Registering clusters to Argo CD...\n"
kubectl config set-context --current --namespace=argocd
argocd cluster add "${PROD_CLUSTER_NAME}" --name "${PROD_CLUSTER_NAME}" --core --yes || true
argocd cluster set "in-cluster" --name "${DEV_CLUSTER_NAME}"

printf "DONE\n"
printf "Console URL %s\n" "localhost:8080"
printf "Your ArgoCD UI credentials:\n"
printf "username: %s\n" "admin"
printf "password %s\n" "${argocd_password}"
