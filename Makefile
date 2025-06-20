# --- Run Target ---
.PHONY: runci
runci: 
	act --container-architecture linux/amd64 -s SONAR_TOKEN -W '.github/workflows/ci.yml'

.PHONY: runcd
runcd: 
	act --container-architecture linux/amd64 --quiet -s REGISTRY_USERNAME -s REGISTRY_PASSWORD -s SONAR_TOKEN -W '.github/workflows/cd.yml'

.PHONY: release
release:
	release-it --no-increment
