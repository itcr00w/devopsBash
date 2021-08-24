echo "docker commands -Victor Soto"

docker network create --attachable atnet  

mkdir ~/postgresql && mkdir ~/postgresql_data

docker run -d --name victordb  --network atnet --restart always  -e POSTGRES_USER=victordb -e POSTGRES_PASSWORD=4e3w2Q1-  -v ~/postgresql:/var/lib/postgresql -v ~/postgresql_data:/var/lib/postgresql/data  postgres

docker volume create sonarqube_data
docker volume create sonarqube_extensions
docker volume create sonarqube_logs

docker run -d --name victor-sonarqube  --network atnet -p 9000:9000  -e SONARQUBE_JDBC_URL=jdbc:postgresql://victordb:5432/victordb  -e SONAR_JDBC_USERNAME=victor  -e SONAR_JDBC_PASSWORD=victoradmin  -v sonarqube_data:/opt/sonarqube/data  -v sonarqube_extensions:/opt/sonarqube/extensions  -v sonarqube_logs:/opt/sonarqube/logs sonarqube:8.9.0-community  


docker container logs victor-sonarqube

sudo sysctl -w vm.max_map_count=262144

docker volume create jenkins_home

docker run -d --network atnet  -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts

docker run --name victor-nexus -d --network atnet -p 8081:8081 sonatype/nexus

