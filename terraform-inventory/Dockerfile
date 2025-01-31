FROM python:3.13-slim

WORKDIR /app

ADD requirements.txt /app/requirements.txt

RUN pip install --upgrade -r requirements.txt

COPY ./ /app

ENTRYPOINT ["python", "terraform_inventory.py"]