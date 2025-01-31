FROM python:3.13-slim

RUN apt-get update -y && apt-get install openssh-client git \
                 python3-future python3-ldap python3-netaddr \
                 python3-dnspython python3-passlib python3-toml \
                 build-essential python3-dev libffi-dev libssl-dev \
                 libsasl2-dev libldap2-dev python3-pip -y

RUN useradd -ms /bin/bash ansible

COPY id_rsa /home/ansible/.ssh/id_rsa

RUN chown -R ansible:ansible /home/ansible/.ssh && \ 
    chmod -R 700 /home/ansible/.ssh

USER ansible

WORKDIR /home/ansible

RUN mkdir project

RUN which ssh-agent; \
    eval $(ssh-agent -s); \
    ssh-add /home/ansible/.ssh/id_rsa;

# RUN ssh-agent bash && ssh-add /home/ansible/.ssh/id_rsa
ENV PATH=$PATH:/home/ansible/.local/bin
RUN pip3 install --user --upgrade debops[ansible]

WORKDIR /home/ansible/project

CMD ["bash"]