#!/usr/bin/env bash
#The node should have memory=2300

kubectl apply -f prod-deployment-guaranted.yml --namespace=prod
kubectl apply -f dev-deployment-burstable.yml --namespace=dev
ps -ef|grep port-forward| awk '{print $2}' |  xargs -I {} kill -9 {}
sleep 10
kubectl get pods --namespace=prod|grep -v NAME| awk '{print $1}'|xargs -I {} kubectl port-forward {} 8099:8080 --namespace=prod&
kubectl get pods --namespace=dev|grep -v NAME| awk '{print $1}'|xargs -I {} kubectl port-forward {} 8069:8080 --namespace=dev&
docker run -it --net=host hjacobs/kube-ops-view

#Go to http://localhost:8099/-/mem and allocato 500Mb 3 times, then go to http://localhost:8069/-/mem and allocate 500 Mb. Kube will restart the production pod

