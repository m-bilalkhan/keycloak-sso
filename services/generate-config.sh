#!/bin/bash

# Get EC2 public IP
PUBLIC_IP=$(curl -s http://checkip.amazonaws.com/)

echo "Public IP: $PUBLIC_IP"

# Create keycloak.json with correct IP
cat <<EOF > ./web-app/keycloak.json
{
  "realm": "demo-realm",
  "auth-server-url": "https://$PUBLIC_IP/",
  "resource": "node-client",
  "ssl-required": "all",
  "public-client": true,
  "confidential-port": 0
}
EOF

# Also replace redirect URIs in demo-realm.json
sed -i "s|https://PUBLIC_IP_ADDRESS|https://$PUBLIC_IP|g" ./keycloak/demo-realm.json
