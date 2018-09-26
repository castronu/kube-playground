./dind-cluster-v1.8.sh up

A kubernetes cluster with 3 nodes is started.
Logs show dashboard. 

Runs kube ops view: https://github.com/hjacobs/kube-ops-view

To access the webapp, you need to use the proxy url:

http://127.0.0.1:32768/api/v1/namespaces/default/services/hello-node:/proxy/