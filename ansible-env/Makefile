# Makefile to build and verify Ansible Docker image
ANSIBLE_VERSION ?= 11.4.0 # Installed by default
ANSIBLE_CORE_VERSION ?= 2.16.14 # Enable in Dockerfile
ANSIBLE_LINT_VERSION ?= 24.12.2
IMAGE_NAME ?= ansible
IMAGE_TAG ?= stable
DOCKERFILE ?= ansible.Dockerfile

build:
	docker build \
		--build-arg ANSIBLE_CORE_VERSION=$(ANSIBLE_CORE_VERSION) \
		--build-arg ANSIBLE_VERSION=$(ANSIBLE_VERSION) \
		--build-arg ANSIBLE_LINT_VERSION=$(ANSIBLE_LINT_VERSION) \
		-t $(IMAGE_NAME):$(IMAGE_TAG) \
		-f $(DOCKERFILE) .

check:
	@echo "🔍 Checking installed versions in $(IMAGE_NAME):$(IMAGE_TAG)..."
	@docker run --rm $(IMAGE_NAME):$(IMAGE_TAG) ansible --version
	@docker run --rm $(IMAGE_NAME):$(IMAGE_TAG) ansible-lint --version
	@docker run --rm $(IMAGE_NAME):$(IMAGE_TAG) python3 --version
	@docker run --rm $(IMAGE_NAME):$(IMAGE_TAG) pip3 --version

all: build check

.PHONY: build check all
