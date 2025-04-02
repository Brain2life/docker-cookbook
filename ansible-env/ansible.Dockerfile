# Use the stable Alpine image
FROM alpine:3.21.3

# Set the working directory for Ansible
WORKDIR /ansible

# Define argument variables for versions
ARG ANSIBLE_CORE_VERSION
ARG ANSIBLE_VERSION
ARG ANSIBLE_LINT_VERSION

# Disable pip cache
ENV PIP_NO_CACHE_DIR=1

# Disable root user warining for pip
ENV PIP_ROOT_USER_ACTION=ignore

# Supporting dependencies and utilities
ENV BUILD_PACKAGES="python3-dev py3-pip cargo build-base libffi-dev openssl-dev ca-certificates openssl openssh-client python3 sshpass git rsync"

# Set metadata for the Docker image
LABEL maintainer="Maxat Akbanov" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.name="makbanov/ansible" \
    org.label-schema.description="Run Ansible within Docker" \
    org.label-schema.url="https://github.com/Brain2life/docker-cookbook" \
    org.label-schema.vcs-url="https://github.com/Brain2life/docker-cookbook" \
    org.label-schema.vendor="Maxat Akbanov (Brain2life)"

# Update image packages
RUN apk --no-cache update && \
    apk --no-cache upgrade -a

# Install essential packages and clean up
RUN apk --no-cache add ${BUILD_PACKAGES} && \
    python3 -m pip install --no-cache-dir --upgrade pip --break-system-packages && \
    pip3 install --no-cache-dir --upgrade wheel --break-system-packages && \
    pip3 install --no-cache-dir --upgrade cryptography cffi certifi --break-system-packages && \
    pip3 install --no-cache-dir ansible==${ANSIBLE_VERSION} --break-system-packages && \
    pip3 install --no-cache-dir ansible-lint==${ANSIBLE_LINT_VERSION} --break-system-packages && \
    pip3 install --no-cache-dir --upgrade pywinrm --break-system-packages && \
    # apk del build-dependencies && \
    rm -rf /var/cache/apk/* && \
    rm -rf /root/.cache/pip && \
    find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf && \
    find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf && \
    rm -rf /root/.cargo

# Prepare default Ansible directory structure and basic inventory file
RUN mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

# Default command for the container
CMD [ "ansible-playbook", "--version" ]
