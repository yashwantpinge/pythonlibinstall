# base image
FROM python:3.7.4-alpine AS base
COPY ./vcodev /usr/src/vcodev
WORKDIR /usr/src/vcodev

RUN apk update \
    && apk add gcc musl-dev \
    && rm -f Pipfile.lock \
    && pip install .
