# java-bulettin-board

## Buat jaringan docker
docker network create bulletin-network

## Runing database with docker
docker run --name bulletin-postgres --network bulletin-network -e POSTGRES_PASSWORD=password -e POSTGRES_USER=postgres -e POSTGRES_DB=bulletin_board -v /path/to/local/folder:/var/lib/postgresql/data -p 5432:5432 -d postgres:latest

## Running tomcat with docker
docker run -d --name bulletin-tomcat -p 8080:8080 --network bulletin-network -v /path/to/local/folder:/usr/local/tomcat/webapps tomcat:10-jdk21
