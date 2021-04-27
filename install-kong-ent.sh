#!/bin/sh
k3d cluster create mycluster --k3s-server-arg '--disable=traefik' -p '8000:31000@agent[0]' -p '8001:31001@agent[0]' -p '8002:31002@agent[0]' -p '8003:31003@agent[0]' -p '8004:31004@agent[0]' --agents 1
kubectl apply -f kong-ent-namespace.yaml
kubectl create secret generic kong-enterprise-license --from-file=license=./license.json -n kong-ent
kubectl create secret generic kong-enterprise-superuser-password -n kong-ent --from-literal=password=KingKong
kubectl create secret generic kong-session-config -n kong-ent --from-file=admin_gui_session_conf --from-file=portal_session_conf
helm install kong-ent kong/kong -n kong-ent --values ./kong-enterprise.yaml
