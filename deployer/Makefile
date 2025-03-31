# Versions
HELMFILE_VERSION = 0.171.0
HELM_VERSION = 3.17.2
SOPS_VERSION = 3.10.0
KUBECTL_VERSION = 1.32.0
TERRAFORM_VERSION = 1.11.3
HELMSMAN_APP_VERSION = 3.18.0

# Helm plugins
HELM_DIFF = 3.8.1
HELM_GIT = 0.15.1
HELM_S3 = 0.10.0
HELM_SECRETS = 4.5.1

# Image name
IMAGE_NAME = deployer

# Print the version arguments
print-args:
	@echo "Building Docker image with the following versions:"
	@echo "  HELMFILE_VERSION       = $(HELMFILE_VERSION)"
	@echo "  HELM_VERSION           = $(HELM_VERSION)"
	@echo "  SOPS_VERSION           = $(SOPS_VERSION)"
	@echo "  KUBECTL_VERSION        = $(KUBECTL_VERSION)"
	@echo "  TERRAFORM_VERSION      = $(TERRAFORM_VERSION)"
	@echo "  HELMSMAN_APP_VERSION   = $(HELMSMAN_APP_VERSION)"
	@echo "  HELM_DIFF              = $(HELM_DIFF)"
	@echo "  HELM_GIT               = $(HELM_GIT)"
	@echo "  HELM_S3                = $(HELM_S3)"
	@echo "  HELM_SECRETS           = $(HELM_SECRETS)"

# Build the Docker image
build: print-args
	docker build \
		--build-arg HELMFILE_VERSION=$(HELMFILE_VERSION) \
		--build-arg HELM_VERSION=$(HELM_VERSION) \
		--build-arg SOPS_VERSION=$(SOPS_VERSION) \
		--build-arg KUBECTL_VERSION=$(KUBECTL_VERSION) \
		--build-arg TERRAFORM_VERSION=$(TERRAFORM_VERSION) \
		--build-arg HELMSMAN_APP_VERSION=$(HELMSMAN_APP_VERSION) \
		--build-arg HELM_DIFF=$(HELM_DIFF) \
		--build-arg HELM_GIT=$(HELM_GIT) \
		--build-arg HELM_S3=$(HELM_S3) \
		--build-arg HELM_SECRETS=$(HELM_SECRETS) \
		-t $(IMAGE_NAME) \
		-f deployer.Dockerfile .
