# --- Run Target ---
.PHONY: runci
runci: 
	act --container-architecture linux/amd64 --container-options "--privileged" -s REGISTRY_USERNAME -s REGISTRY_PASSWORD -W '.github/workflows/ci.yml'

.PHONY: runcd2
runcd2: 
	act --container-architecture linux/amd64 --bind --privileged -s REGISTRY_USERNAME -s REGISTRY_PASSWORD -W '.github/workflows/cd.yml'


.PHONY: runcd
runcd: 
	act -s REGISTRY_USERNAME -s REGISTRY_PASSWORD -P ubuntu-latest=ghcr.io/catthehacker/ubuntu:act-latest -W .github/workflows/cd.yml


.PHONY: lsregistry
lsregistry:
	curl http://localhost:7001/v2/goapp/tags/list