#!/usr/bin/env bash
docker pull jenkins/jenkins
docker run -p 8080:8080 -p 5000:5000 jenkins/jenkins:latest

