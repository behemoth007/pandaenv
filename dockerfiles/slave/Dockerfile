FROM ubuntu:18.04

WORKDIR /home

COPY agent.jar .

RUN apt-get update -y
RUN apt-get install -y curl
RUN apt-get install -y openjdk-11-jdk
RUN apt-get install -y git
RUN apt-get install -y maven

RUN  adduser --disabled-password --gecos "" jenkins

RUN curl -fsSL https://get.docker.com/ | sh
RUN usermod -aG docker jenkins