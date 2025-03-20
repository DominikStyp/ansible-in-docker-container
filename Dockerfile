FROM alpine:3.21

ENV TERRAFORM_VER 1.11.2

RUN apk update && apk add ansible && \
	apk --update --no-cache add python3 py3-pip curl jq openssh sshpass libc6-compat git openssh-client 

RUN pip3 install --no-cache-dir awscli --break-system-packages && \
    pip3 install --upgrade boto3 botocore --break-system-packages

RUN cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip -o terraform_${TERRAFORM_VER}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VER}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VER}_linux_amd64.zip && \
    chmod +x /usr/local/bin/terraform

RUN ansible-galaxy collection install community.aws
RUN ansible-galaxy collection install --no-cache --force community.docker
