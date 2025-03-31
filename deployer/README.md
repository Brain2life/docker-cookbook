# Deployer image

Use this Dockerfile to build deployment-focused `deployer` image containing: 
- [Helmfile](https://github.com/helmfile/helmfile) 
- [Helm](https://helm.sh/docs/intro/install/)
- [SOPS](https://github.com/getsops/sops) 
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
- [Terraform](https://developer.hashicorp.com/terraform/install) 
- [Helmsman](https://github.com/Praqma/helmsman)
- [Helm diff plugin](https://github.com/databus23/helm-diff)
- [Helm plugin for AWS S3 Chart repository support](https://github.com/hypnoglow/helm-s3)
- [Helm plugin that help manage secrets with Git workflow and store them anywhere](https://github.com/jkroepke/helm-secrets)

Base images:
- [Ubuntu](https://hub.docker.com/_/ubuntu)
- [Alpine](https://hub.docker.com/_/alpine)

## ✅ Verify CLI tool versions

To verify installed tool versions, build `deployer` docker image and run container:
```bash
make build
docker run -it --rm deployer /bin/bash 
```

![](https://i.imgur.com/PrIfvgO.png)

## 🔧 What is Helmfile?

[**Helmfile**](https://helmfile.readthedocs.io/en/latest/#status) is a **declarative configuration tool** for managing **Helm** charts — which are templates for deploying applications on Kubernetes.

Instead of running multiple `helm install` or `helm upgrade` commands manually, you define everything in one file (`helmfile.yaml`) and let Helmfile take care of:

- Installing
- Upgrading
- Deleting
- Syncing
- Rendering

multiple Helm charts at once.

---

### 🧠 Why Use Helmfile?

Helm alone is great, but when you have:
- Many charts
- Different environments (e.g., staging, prod)
- Complex dependencies

…it can get messy.

Helmfile helps you:
- Keep your configuration **organized**
- Use **version control** easily (via YAML)
- Apply consistent settings across environments
- Run **all Helm commands in one shot**

---

### 🗂️ What Does a Helmfile Look Like?

```yaml
repositories:
  - name: bitnami
    url: https://charts.bitnami.com/bitnami

releases:
  - name: my-app
    namespace: default
    chart: bitnami/nginx
    version: 13.2.18
    values:
      - values.yaml
```

This example:
- Adds a Helm repo
- Deploys an NGINX chart
- Uses values from `values.yaml`

---

### 💻 Common Commands

- `helmfile apply` — syncs your cluster with the `helmfile.yaml`
- `helmfile sync` — installs/upgrades releases
- `helmfile destroy` — deletes all releases
- `helmfile lint` — checks your helmfile for errors

---

### 🌍 Great For:

- DevOps engineers managing multiple Helm deployments
- CI/CD pipelines
- Multi-env or multi-cluster setups

## ⚓ What is **Helmsman**?

[**Helmsman**](https://www.eficode.com/blog/introducing-helmsman) is a **Kubernetes Helm Charts-as-Code** tool written in **Go** that lets you **manage and deploy Helm charts declaratively** using a simple configuration file written in **DSF (Desired State File)**, which is TOML-based (YAML can also be used).

---

### 💡 What Does Helmsman Do?

Helmsman helps you **define**, **track**, and **enforce** the desired state of your **Helm chart deployments** on Kubernetes. It automates:

- Installing charts
- Upgrading charts
- Deleting/cleaning up old releases
- Managing Helm repositories
- Controlling access via RBAC
- Supporting multi-cluster setups

---

### 📄 Sample Helmsman Desired State File (DSF)

```yaml
namespaces:
  default:

apps:
  my-nginx:
    name: nginx
    namespace: default
    enabled: true
    chart: bitnami/nginx
    version: 13.2.18
    valuesFile: ./nginx-values.yaml
```

This tells Helmsman to:
- Deploy an NGINX chart into the `default` namespace
- Use the given values file
- Ensure the chart is at a specific version

---

### ✅ Features

- **Idempotent**: Running it multiple times won’t cause unwanted changes
- **State enforcement**: Only applies what's needed
- **Security-conscious**: Can run with limited Kubernetes RBAC
- **Drift detection**: Can show differences between declared and live state
- **Templating**: Supports environment templating and dynamic values

---

### 🔁 Comparison: **Helmsman vs Helmfile**

| Feature                  | Helmsman                      | Helmfile                      |
|--------------------------|-------------------------------|-------------------------------|
| Language                 | Go                             | Go                             |
| Config Format            | TOML, YAML (custom DSF schema)       | YAML (helmfile.yaml format)   |
| Templating               | Built-in templating            | Uses Go templating (Sprig)    |
| Drift detection          | ✅                              | ✅ (via `helm diff` plugin)    |
| Complexity               | Simpler for basic setups       | More flexible for advanced use|
| RBAC-aware               | ✅                              | ❌ (not built-in)              |

---

### 🧰 When to Use Helmsman?

- You want a **simple, opinionated**, and **secure** way to manage Helm charts
- You’re working in **RBAC-restricted environments**
- You need **auditability** and **policy enforcement**
