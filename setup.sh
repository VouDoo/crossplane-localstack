# install crossplane in k8s cluster
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update
helm install crossplane crossplane-stable/crossplane --namespace crossplane-system --create-namespace

# install provider aws
kubectl apply -f ./provider-aws.yaml
kubectl wait $(kubectl get provider -o name) --for=condition=Installed --timeout=60s
kubectl wait $(kubectl get provider -o name) --for=condition=Healthy --timeout=60s

# add provider config for localstack
kubectl apply -f ./provider-config-localstack.yaml
