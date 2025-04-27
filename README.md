# InPost DevOps Engineer Assessment

Copyright Łukasz Niedźwiadek 2025

## Running the ArgoCD environment

To run the project execute:

```shell
minikube delete --all # ensure no other clusters are running
./bootstrap_environment.sh
```

Following command will create:

- Two minikube clusters with ArgoCD installed on one of them.
- Deployment of a Helm Chart to both Clusters via ApplicationSet custom resource.

> [!WARNING]  
> Currently only supported way of auto-registering 2nd minikube cluster is using Docker Desktop.
