# Custom Docker image with a containerized environment for running Ansible

![](https://i.imgur.com/EWhR7r2.png)

## Overview

This Dockerfile **installs full-featured Ansible package by default**. Base image is [Alpine](https://hub.docker.com/_/alpine/).

To enable installation of Ansible Core, add the following line to the Dockerfile and remove installation of full Ansible version from Dockerfile and Makefile:
```bash
pip3 install --no-cache-dir ansible==${ANSIBLE_CORE_VERSION} --break-system-packages && \
```

At the same time, you can **install Ansible Core** by specifying version in `ANSIBLE_CORE_VERSION` argument and replacing `ANSIBLE_VERSION` to `ANSIBLE_CORE_VERSION` in the following line of code:
```docker
pip3 install --no-cache-dir ansible==${ANSIBLE_VERSION} --break-system-packages && \
```

> [!CAUTION] 
> `--break-system-packages` flag: Allows pip to install/overwrite packages even if it might break system Python. Use that flag for Docker containers only.

**Additional packages** installed via `BUILD_PACKAGES` variable. The following packages are installed:
- `python3-dev` 
- `py3-pip` 
- `cargo`
- `build-base` 
- `libffi-dev` 
- `openssl-dev` 
- `ca-certificates` 
- `openssl`
- `openssh-client` 
- `python3`
- `sshpass` 
- `git`
- `rsync` 

## Python dependencies

If you need to add additional packages into the Docker image along with Ansible package, then generate or specify `requirements.txt` file.

In Dockerfile add the following lines:
```docker
# Copy Python dependency packages
COPY requirements.txt .

# Install packages
RUN pip install -r requirements.txt
```

In your local project if you want to get all the current Python dependency files with versions, then run the following command:
```bash
pip freeze > requirements.txt
```

## **What’s the difference between Ansible and Ansible Core?**

### **Ansible Core (`ansible-core`)**
- This is the **minimal, essential part of Ansible**.
- It includes the core CLI tools like:
  - `ansible`
  - `ansible-playbook`
  - `ansible-config`
  - basic modules (e.g., file, copy, service)
- It's designed for those who want **just the core engine** and will manually add collections or modules.

**Think of it as the "engine" of Ansible.**

📦 PyPI package: [`ansible-core`](https://pypi.org/project/ansible-core/)

---

### **Ansible (full)**
- This is a **meta-package** that includes:
  - `ansible-core`
  - **A curated set of collections** (modules, roles, plugins)
  - Quality-of-life tools for easier use
- It’s meant to provide a **ready-to-use experience** out of the box.

📦 PyPI package: [`ansible`](https://pypi.org/project/ansible/)

---

| Feature             | `ansible-core`     | `ansible`             |
|---------------------|--------------------|------------------------|
| Core tools          | ✅                 | ✅                     |
| Extra collections   | ❌                 | ✅                     |
| Preconfigured       | ❌                 | ✅                     |
| Use case            | Minimalist/custom  | Full-featured out-of-box |

---

### **What is Ansible Lint?**

[`ansible-lint`](https://ansible.readthedocs.io/projects/lint/) is a **static code analysis tool** for Ansible playbooks, roles, and tasks.

It helps you:
- Find syntax errors
- Enforce best practices
- Catch common mistakes
- Make playbooks more consistent, readable, and secure

### TL;DR

| Term            | What it is                                    |
|-----------------|-----------------------------------------------|
| **Ansible Core** | The minimal base CLI and core modules        |
| **Ansible**      | Full package with `ansible-core` + extras    |
| **Ansible Lint** | A linter tool to check/playbooks for best practices |

## How to build the image?

To build the image, run the following command:
```bash
make build
```

This command builds `ansible:stable` image by default. 

You can override the following parameters:
- ANSIBLE_CORE_VERSION
- ANSIBLE_VERSION
- ANSIBLE_LINT
- IMAGE_NAME
- IMAGE_TAG
- DOCKERFILE

For example:
```bash
make build ANSIBLE_VERSION=9.6.1 IMAGE_TAG=latest
```

To build the image and check versions at the same time, run:
```bash
make build check
```

## Labeling Docker image

Labels (Docker image metadata) added to the Docker image to make it:
- Easier to understand (who made it, what it’s for)
- Easier to document or index (e.g., in Docker registries or CI pipelines)
- More traceable (via URLs, Git repo, and vendor info)

To see labels, run:
```bash
docker inspect ansible:stable
```

## References
- [ansible-lint](https://pypi.org/project/ansible-lint/)