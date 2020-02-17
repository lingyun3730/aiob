#!/bin/bash
minikube delete && minikube start --cpus=2 --memory=8072 --disk-size=20g \
	--registry-mirror=https://registry.docker-cn.com \
  --insecure-registry=LM-SHC-16507656:5000