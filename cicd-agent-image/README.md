# Dockerfile to build image for BitBucket CI/CD agents with awscli and ssm

As a base image, this Dockerfile uses Atlassian's official Ubuntu 20.04 LTS image. For more information, see [default images](https://hub.docker.com/r/atlassian/default-image).

Docker image for CI/CD pipeline agents: [makbanov/ubuntu-agent](https://hub.docker.com/r/makbanov/ubuntu-agent)

Built image includes the following tools:
- AWS CLI
- AWS SSM Plugin
- Helm3
- Docker