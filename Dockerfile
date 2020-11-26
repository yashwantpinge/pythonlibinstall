# base image
FROM python:3.7.4 AS base
WORKDIR C:\\Users\\vcosmos\\AppData\\Local\\Jenkins\\.jenkins\\workspace\\SFT_Automation
COPY requiremnets.txt .
RUN pip install --user -r requiremnets.txt
