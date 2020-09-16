#!/bin/bash
useradd -u 1030 artifactory
chown -R 777 ./volumes/artifactory
chown -R 777 ./volumes/jenkins
cd compose
docker-compose up -d --build