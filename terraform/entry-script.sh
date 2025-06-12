#!bin/bash
sudo yum update -y && sudo yum install docker -y
sudo systemctl start docker
sudo usermod -aG docker ec2-user

#Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

newgrp docker

#Clone GitHub project
#Setting it public for easy access
git clone --depth=1 --filter=blob:none --sparse https://github.com/m-bilalkhan/your-repo.git
cd your-repo
git sparse-checkout set docker-app
cd docker-app


docker-compose up --build -d