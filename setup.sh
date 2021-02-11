#!/bin/sh
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml

# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f ./yamlfiles/metallb-config.yaml
kubectl apply -f ./yamlfiles/mysql-secret.yaml
arr=(
    nginx
    phpmyadmin
    wordpress
    mysql
    grafana
    influxdb
    ftps
)

for i in "${arr[@]}"; do
    kubectl delete -f ./srcs/yamlfiles/$i.yaml
done
for i in "${arr[@]}"; do
    docker build -t $i ./srcs/$i/
done
for i in "${arr[@]}"; do
    kubectl apply -f ./srcs/yamlfiles/$i.yaml
done