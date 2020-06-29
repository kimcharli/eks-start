# eks-start


Doing eksctl 
- https://eksctl.io/introduction/
```bash
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl create cluster --name=eks-3

ckim-mbp:temp ckim$ eksctl create cluster --name=eks-3
[ℹ]  eksctl version 0.22.0
[ℹ]  using region us-west-2
[ℹ]  setting availability zones to [us-west-2c us-west-2d us-west-2a]
[ℹ]  subnets for us-west-2c - public:192.168.0.0/19 private:192.168.96.0/19
[ℹ]  subnets for us-west-2d - public:192.168.32.0/19 private:192.168.128.0/19
[ℹ]  subnets for us-west-2a - public:192.168.64.0/19 private:192.168.160.0/19
[ℹ]  nodegroup "ng-fe308fee" will use "ami-06e2c973f2d0373fa" [AmazonLinux2/1.16]
[ℹ]  using Kubernetes version 1.16
[ℹ]  creating EKS cluster "eks-3" in "us-west-2" region with un-managed nodes
[ℹ]  will create 2 separate CloudFormation stacks for cluster itself and the initial nodegroup
[ℹ]  if you encounter any issues, check CloudFormation console or try 'eksctl utils describe-stacks --region=us-west-2 --cluster=eks-3'
[ℹ]  CloudWatch logging will not be enabled for cluster "eks-3" in "us-west-2"
[ℹ]  you can enable it with 'eksctl utils update-cluster-logging --region=us-west-2 --cluster=eks-3'
[ℹ]  Kubernetes API endpoint access will use default of {publicAccess=true, privateAccess=false} for cluster "eks-3" in "us-west-2"
[ℹ]  2 sequential tasks: { create cluster control plane "eks-3", 2 sequential sub-tasks: { no tasks, create nodegroup "ng-fe308fee" } }
[ℹ]  building cluster stack "eksctl-eks-3-cluster"
[ℹ]  deploying stack "eksctl-eks-3-cluster"
[ℹ]  building nodegroup stack "eksctl-eks-3-nodegroup-ng-fe308fee"
[ℹ]  --nodes-max=2 was set automatically for nodegroup ng-fe308fee
[ℹ]  deploying stack "eksctl-eks-3-nodegroup-ng-fe308fee”
[ℹ]  deploying stack "eksctl-eks-3-nodegroup-ng-fe308fee"
[ℹ]  waiting for the control plane availability...
[✔]  saved kubeconfig as "/Users/ckim/.kube/config"
[ℹ]  no tasks
[✔]  all EKS cluster resources for "eks-3" have been created
[ℹ]  adding identity "arn:aws:iam::916732097451:role/eksctl-eks-3-nodegroup-ng-fe308fe-NodeInstanceRole-CK35UR120XBH" to auth ConfigMap
[ℹ]  nodegroup "ng-fe308fee" has 0 node(s)
[ℹ]  waiting for at least 2 node(s) to become ready in "ng-fe308fee"
[ℹ]  nodegroup "ng-fe308fee" has 2 node(s)
[ℹ]  node "ip-192-168-31-127.us-west-2.compute.internal" is ready
[ℹ]  node "ip-192-168-41-35.us-west-2.compute.internal" is ready
[ℹ]  kubectl command should work with "/Users/ckim/.kube/config", try 'kubectl get nodes'
[✔]  EKS cluster "eks-3" in "us-west-2" region is ready
ckim-mbp:temp ckim$
ckim-mbp:temp ckim$ kubectl get all -A
NAMESPACE     NAME                           READY   STATUS    RESTARTS   AGE
kube-system   pod/aws-node-swzlj             1/1     Running   0          6m5s
kube-system   pod/aws-node-t9n4z             1/1     Running   0          6m5s
kube-system   pod/coredns-5c97f79574-8r2xw   1/1     Running   0          13m
kube-system   pod/coredns-5c97f79574-k29qs   1/1     Running   0          13m
kube-system   pod/kube-proxy-6rfsd           1/1     Running   0          6m5s
kube-system   pod/kube-proxy-6t9jv           1/1     Running   0          6m5s


NAMESPACE     NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)         AGE
default       service/kubernetes   ClusterIP   10.100.0.1    <none>        443/TCP         13m
kube-system   service/kube-dns     ClusterIP   10.100.0.10   <none>        53/UDP,53/TCP   13m


NAMESPACE     NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
kube-system   daemonset.apps/aws-node     2         2         2       2            2           <none>          13m
kube-system   daemonset.apps/kube-proxy   2         2         2       2            2           <none>          13m


NAMESPACE     NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   deployment.apps/coredns   2/2     2            2           13m


NAMESPACE     NAME                                 DESIRED   CURRENT   READY   AGE
kube-system   replicaset.apps/coredns-5c97f79574   2         2         2       13m
ckim-mbp:temp ckim$
```

## dashboard

```bash

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

ckim-mbp:temp ckim$ kubectl get all -n kubernetes-dashboard
NAME                                            READY   STATUS    RESTARTS   AGE
pod/dashboard-metrics-scraper-c79c65bb7-mmqbq   1/1     Running   0          46s
pod/kubernetes-dashboard-56484d4c5-8sdls        1/1     Running   0          46s

NAME                                TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/dashboard-metrics-scraper   ClusterIP   10.100.187.243   <none>        8000/TCP   46s
service/kubernetes-dashboard        ClusterIP   10.100.190.219   <none>        443/TCP    49s

NAME                                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/dashboard-metrics-scraper   1/1     1            1           47s
deployment.apps/kubernetes-dashboard        1/1     1            1           47s

NAME                                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/dashboard-metrics-scraper-c79c65bb7   1         1         1       47s
replicaset.apps/kubernetes-dashboard-56484d4c5        1         1         1       47s
ckim-mbp:temp ckim$
```

```bash
kubectl proxy --port=8080 --address=0.0.0.0 --disable-filter=true &
```

access http://localhost:8080/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login

get token here, and use it.
```ckim-mbp:~ ckim$ aws-iam-authenticator token -i eks-3
{"kind":"ExecCredential","apiVersion":"client.authentication.k8s.io/v1alpha1","spec":{},"status":{"expirationTimestamp":"2020-06-26T05:24:28Z","token":"k8s-aws-v1.very-very-long"}}
ckim-mbp:~ ckim$
```


## example1


```bash
aws iam get-role --role-name "AWSServiceRoleForElasticLoadBalancing" || aws iam create-service-linked-role --aws-service-name "elasticloadbalancing.amazonaws.com"
```

## helm

```bash
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

this is optional, and might be incomplete
```
helm completion bash >> ~/.bash_completion
. /etc/profile.d/bash_completion.sh
. ~/.bash_completion
source <(helm completion bash)
```

```bash
ckim-mbp:temp ckim$ helm install mywebserver bitnami/nginx
NAME: mywebserver
LAST DEPLOYED: Fri Jun 26 01:26:32 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Get the NGINX URL:

  NOTE: It may take a few minutes for the LoadBalancer IP to be available.
        Watch the status with: 'kubectl get svc --namespace default -w mywebserver-nginx'

  export SERVICE_IP=$(kubectl get svc --namespace default mywebserver-nginx --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")
  echo "NGINX URL: http://$SERVICE_IP/"
ckim-mbp:temp ckim$
ckim-mbp:temp ckim$ kubectl get svc,po,deploy
NAME                        TYPE           CLUSTER-IP       EXTERNAL-IP                                                               PORT(S)                      AGE
service/kubernetes          ClusterIP      10.100.0.1       <none>                                                                    443/TCP                      73m
service/mywebserver-nginx   LoadBalancer   10.100.109.158   ae2aa9bf266e6404cbdfea31959806f1-1680488034.us-west-2.elb.amazonaws.com   80:31625/TCP,443:30901/TCP   16s

NAME                                     READY   STATUS    RESTARTS   AGE
pod/mywebserver-nginx-7fbff567c8-lt5kv   1/1     Running   0          16s

NAME                                READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mywebserver-nginx   1/1     1            1           16s
ckim-mbp:temp ckim$
```

access http://ae2aa9bf266e6404cbdfea31959806f1-1680488034.us-west-2.elb.amazonaws.com/

cleaning up
```bash
ckim-mbp:temp ckim$ helm list
NAME       	NAMESPACE	REVISION	UPDATED                             	STATUS  	CHART      	APP VERSION
mywebserver	default  	1       	2020-06-26 01:26:32.786171 -0400 EDT	deployed	nginx-6.0.1	1.19.0
ckim-mbp:temp ckim$
ckim-mbp:temp ckim$ helm uninstall mywebserver
release "mywebserver" uninstalled
ckim-mbp:temp ckim$
ckim-mbp:temp ckim$ kubectl get svc,po,deploy
NAME                        TYPE           CLUSTER-IP       EXTERNAL-IP                                                               PORT(S)                      AGE
service/kubernetes          ClusterIP      10.100.0.1       <none>                                                                    443/TCP                      78m
service/mywebserver-nginx   LoadBalancer   10.100.109.158   ae2aa9bf266e6404cbdfea31959806f1-1680488034.us-west-2.elb.amazonaws.com   80:31625/TCP,443:30901/TCP   5m18s
ckim-mbp:temp ckim$ kubectl get svc,po,deploy
NAME                        TYPE           CLUSTER-IP       EXTERNAL-IP                                                               PORT(S)                      AGE
service/kubernetes          ClusterIP      10.100.0.1       <none>                                                                    443/TCP                      78m
service/mywebserver-nginx   LoadBalancer   10.100.109.158   ae2aa9bf266e6404cbdfea31959806f1-1680488034.us-west-2.elb.amazonaws.com   80:31625/TCP,443:30901/TCP   5m26s
ckim-mbp:temp ckim$ kubectl get svc,po,deploy
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.100.0.1   <none>        443/TCP   78m
ckim-mbp:temp ckim$
```

eksdemo

```bash
ckim-mbp:eks-start ckim$ cd helm/environment/
ckim-mbp:environment ckim$ helm create eksdemo
Creating eksdemo
ckim-mbp:environment ckim$ 

```

cat <<EoF > eksdemo/Chart.yaml
apiVersion: v2
name: eksdemo
description: A Helm chart for EKS Workshop Microservices application
version: 0.1.0
appVersion: 1.0
EoF


## argo

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
curl --silent --location -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v1.6.1/argocd-linux-amd64
chmod +x /usr/local/bin/argocd

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
export ARGOCD_SERVER=`kubectl get svc argocd-server -n argocd -o json | jq --raw-output .status.loadBalancer.ingress[0].hostname`



## CA


https://golang.org/dl/
```bash
ckim-mbp:temp ckim$ brew install golang

ckim-mbp:temp ckim$ go version
go version go1.14.4 darwin/amd64
ckim-mbp:temp ckim$
```

```bash
ckim-mbp:temp ckim$ mkdir hello
ckim-mbp:temp ckim$ cd hello/
ckim-mbp:hello ckim$ go mod init example.com/user/hello
go: creating new go.mod: module example.com/user/hello
ckim-mbp:hello ckim$ ls -al
total 8
drwxr-xr-x  3 ckim  staff   96 Jun 26 13:34 .
drwxr-xr-x  4 ckim  staff  128 Jun 26 13:34 ..
-rw-r--r--  1 ckim  staff   39 Jun 26 13:34 go.mod
ckim-mbp:hello ckim$ cat go.mod
module example.com/user/hello

go 1.14
ckim-mbp:hello ckim$ vi hello.go
ckim-mbp:hello ckim$  go install example.com/user/hello
ckim-mbp:hello ckim$ ls -al
total 16
drwxr-xr-x  4 ckim  staff  128 Jun 26 13:35 .
drwxr-xr-x  4 ckim  staff  128 Jun 26 13:34 ..
-rw-r--r--  1 ckim  staff   39 Jun 26 13:34 go.mod
-rw-r--r--  1 ckim  staff   75 Jun 26 13:35 hello.go
ckim-mbp:hello ckim$ ls -al ~/go/
bin/ pkg/
ckim-mbp:hello ckim$ ls -al ~/go/bin/hello
-rwxr-xr-x  1 ckim  staff  2178184 Jun 26 13:35 /Users/ckim/go/bin/hello
ckim-mbp:hello ckim$
ckim-mbp:hello ckim$ go env | grep GOPATH
GOPATH="/Users/ckim/go"
ckim-mbp:hello ckim$ go env | grep GOBIN
GOBIN=""
ckim-mbp:hello ckim$
```

## [cfssl](cfssl/README)






