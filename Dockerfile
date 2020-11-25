# base image
FROM python:3.7.4 AS base
WORKDIR /usr/src/docker
COPY requiremnets.txt .
RUN pip install --user -r requiremnets.txt
