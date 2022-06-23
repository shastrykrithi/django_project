FROM python:3.9-alpine3.13
#python is docker name in hub.docker.com
#3.9-alpine3.13 name of the tag
LABEL maintainer="krithis"

ENV PYTHONUNBUFFERED 1
#get python logs immediately without any buffer 

COPY ./requirements.txt /tmp/requirements.txt
#copy local .txt file to docker image
COPY ./app /app
#app directory to container
WORKDIR /app
#default dir to run cmds
EXPOSE 8000

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

#create new virtual env
#upgrade package inside venv
#install dependencies in requirements.txt
#remove tmp folder created temporary
#adds new user inside image without password and home dir(note: avoid run as root user) 

ENV PATH="/py/bin:$PATH"
#path environment variable 

USER django-user
#switch from root to django user   