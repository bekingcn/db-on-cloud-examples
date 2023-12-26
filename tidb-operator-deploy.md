**https://docs.pingcap.com/zh/tidb-in-kubernetes/dev/get-started#%E7%AC%AC-2-%E6%AD%A5%E9%83%A8%E7%BD%B2-tidb-operator**

```SH
# with Kind
# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
# For ARM64
# [ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-arm64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# TiDB
kubectl create -f https://raw.githubusercontent.com/pingcap/tidb-operator/master/manifests/crd.yaml
helm repo add pingcap https://charts.pingcap.org/
kubectl create namespace tidb-admin
helm install --namespace tidb-admin tidb-operator pingcap/tidb-operator --version v1.5.1

# check operator
kubectl get pods --namespace tidb-admin -l app.kubernetes.io/instance=tidb-operator

# deploy cluster
kubectl create namespace tidb-cluster && \
    kubectl -n tidb-cluster apply -f https://raw.githubusercontent.com/pingcap/tidb-operator/master/examples/basic/tidb-cluster.yaml

# dashboard
kubectl -n tidb-cluster apply -f https://raw.githubusercontent.com/pingcap/tidb-operator/master/examples/basic/tidb-dashboard.yaml
# monitor
kubectl -n tidb-cluster apply -f https://raw.githubusercontent.com/pingcap/tidb-operator/master/examples/basic/tidb-monitor.yaml

# check TiDB pods


# mysql service
kubectl get svc -n tidb-cluster
# port-forward
# kubectl port-forward -n tidb-cluster svc/basic-tidb 14000:4000 > pf14000.out &
# connect with mysql client
./openmysql-tidb.sh
```