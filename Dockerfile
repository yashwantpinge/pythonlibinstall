# base image
FROM python:3.7.4 AS base
WORKDIR C:\\SFTP\\pythonlibinstall
COPY requiremnets.txt .
RUN pip install --user -r requiremnets.txt
