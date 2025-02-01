FROM python:3.13-slim

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    groff \
    less \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install \
    && rm -rf awscliv2.zip ./aws

WORKDIR /app

ADD requirements.txt /app/requirements.txt

RUN pip install --upgrade -r requirements.txt

COPY ./ /app

ENTRYPOINT ["python", "terraform_inventory.py"]