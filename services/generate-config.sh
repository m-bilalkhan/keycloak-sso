#!/bin/bash

# Get EC2 public IP
PUBLIC_IP=$(curl -s http://checkip.amazonaws.com/)

echo "Public IP: $PUBLIC_IP"

# Create keycloak.json with correct IP
cat <<EOF > ./web-app/keycloak.json
{
  "realm": "demo-realm",
  "auth-server-url": "http://$PUBLIC_IP:8080/auth/",
  "ssl-required": "none",
  "hostname-strict-https": false,
  "resource": "node-client",
  "public-client": true,
  "confidential-port": 0
}
EOF

# Also replace redirect URIs in demo-realm.json
sed -i "s|http://PUBLIC_IP_ADDRESS|http://$PUBLIC_IP|g" ./keycloak/demo-realm.json
