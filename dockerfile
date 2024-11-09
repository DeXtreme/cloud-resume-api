FROM python:3.10-slim-buster

WORKDIR /api

RUN apt update && apt install -y wget gnupg software-properties-common

# Install terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt update && apt install -y terraform

# Install poetry
RUN pip install poetry

COPY ./ ./
RUN poetry install

CMD while sleep 1000; do :; done
