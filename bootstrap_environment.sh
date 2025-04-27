#!/usr/bin/env bash
set -e

DEV_CLUSTER_NAME="dev-global-cluster-0"
PROD_CLUSTER_NAME="prd-global-cluster-5"
KUBECONFIG="$HOME/.kube/config"
DOCKER_HOST_INTERFACE_ADDRESS="host.docker.internal" # change me if NOT using docker desktop

printf "[STEP 1] Starting kubernetes clusters...\n"
minikube start -p "${DEV_CLUSTER_NAME}" --driver docker --listen-address 0.0.0.0
minikube start -p "${PROD_CLUSTER_NAME}"  --driver docker --listen-address 0.0.0.0

printf "Modifying %s kubeconfig for connection to ArgoCD...\n" "${PROD_CLUSTER_NAME}"
yq eval ".clusters[] |= select(.name == \"${PROD_CLUSTER_NAME}\") |= .cluster.server |= sub(\"127.0.0.1\", \"${DOCKER_HOST_INTERFACE_ADDRESS}\")" -i "$KUBECONFIG"

printf "Disabling TLS for %s kubeconfig...\n" "${PROD_CLUSTER_NAME}"
yq eval ".clusters[] |= select(.name == \"${PROD_CLUSTER_NAME}\") |= .cluster.\"insecure-skip-tls-verify\" = true" -i "${KUBECONFIG}"
yq eval "del(.clusters[] | select(.name == \"${PROD_CLUSTER_NAME}\") | .cluster.\"certificate-authority\")" -i "$KUBECONFIG"

printf "\n[STEP 2] Deploying Argo CD via Helm on %s cluster...\n" "${DEV_CLUSTER_NAME}"
kubectl config use-context "${DEV_CLUSTER_NAME}"
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm upgrade --install argocd argo/argo-cd --namespace argocd --values ./argocd/values.yaml --create-namespace
helm upgrade --install inpost-argocd ./argocd --namespace argocd --values ./argocd/values.yaml

printf "Waiting for Argo CD server to become ready...\n"
kubectl rollout status deployment argocd-server -n argocd

printf "Port-forwarding Argo CD UI on localhost:8080...\n"
kubectl port-forward svc/argocd-server -n argocd 8080:443 >/dev/null 2>&1 &
port_forward_pid=$!
printf "\nPort Forward running on PID %s" "${port_forward_pid}"
sleep 3

printf "\n[STEP 3] : Logging into Argo CD CLI...\n"
argocd_password=$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d)
argocd login localhost:8080 --insecure --username admin --password "${argocd_password}"

printf "Registering and labeling clusters into Argo CD...\n"
kubectl config set-context --current --namespace=argocd
argocd cluster add "${PROD_CLUSTER_NAME}" --name "${PROD_CLUSTER_NAME}" --label stage=prod --label app=spring-boot-api --yes || true
argocd cluster set "in-cluster" --name "${DEV_CLUSTER_NAME}" --label app=spring-boot-api --label stage=dev

printf "DONE!\n"
printf "Console URL %s\n" "http://localhost:8080"
printf "Your ArgoCD UI credentials:\n"
printf "username: %s\n" "admin"
printf "password %s\n" "${argocd_password}"
