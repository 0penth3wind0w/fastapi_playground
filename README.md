# FastAPI Playground
Sample API with FastAPI framework to test on AWS environment with terraform

## fastapi
Folder contains API to be deployed

## terraform
Folder contains terraform to be use

API can be added one by one or use proxy resource, all of them are already defined in terraform. Comment the unused one when deployment.

Since there some resource in rest.tf and http.tf share the same name, so pick one(http/REST) when deploying and comment another one.