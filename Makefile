# Set the container runtime based on architecture, default to docker for amd64 and podman for arm64
DOCKER ?= $(shell if [ "$$(uname -m)" = "arm64" ]; then echo podman; else echo docker; fi)

.PHONY: jdk21-maven-node22 gcloud-pubsub-emulator tinyproxy cloudsql-proxy python-pipenv cloud-sdk-terraform eq-stub owasp-venom

jdk21-maven-node22:
	$(DOCKER) build --platform linux/amd64 ./jdk21-maven-node22 -t europe-west2-docker.pkg.dev/c31-rm-ci-prod/rm-docker-snapshot/jdk21-mvn-node22-npm:latest

gcloud-pubsub-emulator:
	$(DOCKER) build --platform linux/amd64 ./gcloud-pubsub-emulator -t europe-west2-docker.pkg.dev/c31-rm-ci-prod/rm-docker-snapshot/gcloud-pubsub-emulator:latest

tinyproxy:
	$(DOCKER) build --platform linux/amd64 ./tinyproxy -t europe-west2-docker.pkg.dev/c31-rm-ci-prod/rm-docker-snapshot/tinyproxy:latest

cloudsql-proxy:
	$(DOCKER) build --platform linux/amd64 ./cloudsql-proxy -t europe-west2-docker.pkg.dev/c31-rm-ci-prod/rm-docker-snapshot/cloudsql-proxy:latest

python-pipenv: python-pipenv-3.14

python-pipenv-3.12:
	$(DOCKER) build --platform linux/amd64 --build-arg="PYTHON_TAG=$$(cat python-pipenv/python-3.12-tag.txt)" ./python-pipenv -t europe-west2-docker.pkg.dev/c31-rm-ci-prod/rm-docker-snapshot/python-pipenv:3.12

python-pipenv-3.14:
	$(DOCKER) build --platform linux/amd64 --build-arg="PYTHON_TAG=$$(cat python-pipenv/python-3.14-tag.txt)" ./python-pipenv -t europe-west2-docker.pkg.dev/c31-rm-ci-prod/rm-docker-snapshot/python-pipenv:3.14

cloud-sdk-terraform:
	$(DOCKER) build --platform linux/amd64 ./cloud-sdk-terraform -t europe-west2-docker.pkg.dev/c31-rm-ci-prod/rm-docker-snapshot/cloud-sdk-terraform:latest

eq-stub:
	$(DOCKER) build --platform linux/amd64 ./eq-stub -t europe-west2-docker.pkg.dev/c31-rm-ci-prod/rm-docker-snapshot/census-rm-eq-stub:latest

owasp-venom:
	$(DOCKER) build --platform linux/amd64 ./owasp-venom -t europe-west2-docker.pkg.dev/c31-rm-ci-prod/rm-docker-snapshot/venom:latest

build-all: jdk21-maven-node22 gcloud-pubsub-emulator tinyproxy cloudsql-proxy python-pipenv python-pipenv-3.12 cloud-sdk-terraform eq-stub owasp-venom
