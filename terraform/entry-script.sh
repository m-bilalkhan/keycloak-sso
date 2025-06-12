#!bin/bash
sudo yum update -y && sudo yum install -y docker git
sudo systemctl start docker
sudo usermod -aG docker ec2-user

#Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

newgrp docker

#Clone GitHub project
#Setting it public for easy access
git clone --depth=1 --filter=blob:none --sparse https://github.com/m-bilalkhan/keycloak-sso.git
cd keycloak-sso
git sparse-checkout set services
cd services


docker-compose up --build -d