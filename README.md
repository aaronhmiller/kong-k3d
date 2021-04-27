# kong-k3d

Local K8S cluster for POCs and quick sniff tests



## Getting Started

1. Install [k3d](https://k3d.io) (assumes you already have Docker installed as a prerequisite)
2. Into the `license.json` place your specific license data
3. `./install-kong-ent.sh` (this creates a k3s cluster named `mycluster`, installs a Postgres DB, initializes its schema, and initializes and installs Kong Enterprise)
4. `kubectl apply -f httpbin.yaml -n kong-ent` (this deploys a container of httpbin)
5. From here, you can either:
   1. run http://localhost:8002 (kong_admin:KingKong) and manually install a Service and Route using the UI* or (preferred)...
   2. use `kubectl apply -f httpbin-ingress.yaml -n kong-ent`
6. Check your proxy by loading http://localhost:8000/httpbin/anything or if using GUI way http://localhost:8000/httpbin2

## Apply a plugin

To see a plugin applied:

1. `kubectl apply -f correlation-plugin.yaml -n kong-ent`
2. now check your proxy again and you should notice the presence of a new header: `"Kong-Request-Id":<some-value>`

Plugins are in Kong Manager <http://localhost:8002> and documented here: https://docs.konghq.com/hub/

For more examples and sample Kong Ingress Controller syntax: https://gist.github.com/nedward/dd445bfa2be781fd9ce32f3122b55895

##### *Guidance on GUI definition method:

Service -> name -> httpbin-service, URL -> http://httpbin.kong-ent.svc.cluster.local

Route -> name -> httpbin-route, path -> /httpbin2

## Cleanup

run `./delete-k3d.sh` to remove *all* your local K3D Kubernetes Cluster(s).

