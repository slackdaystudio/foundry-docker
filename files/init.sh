#!/bin/env bash

# Create SSL certs
certbot certonly --non-interactive --agree-tos -m webmaster@${ENV_HOSTNAME} --standalone -d ${ENV_HOSTNAME}

# Install Foundry
mkdir /home/foundry/foundry && \
unzip /opt/foundryvtt-${ENV_FOUNDRY_VERSION}.zip -d /home/foundry/foundry && \
chown -R foundry:foundry /home/foundry/foundry && \
rm /opt/foundryvtt-${ENV_FOUNDRY_VERSION}.zip && \
mkdir -p /home/foundry/data && \
chown foundry:foundry /home/foundry/data

# Copy over the config file
mkdir -p /home/foundry/data/Config/
cat /opt/options.json > /home/foundry/data/Config/options.json
chown -R foundry:foundry /home/foundry/data

# Configure nginx
cp /opt/app.conf /etc/nginx/sites-available/${HOSTNAME}
sed -i "s/\${HOSTNAME}/${ENV_HOSTNAME}/g" /etc/nginx/sites-available/${HOSTNAME}
ln -s /etc/nginx/sites-available/${HOSTNAME} /etc/nginx/sites-enabled/
service nginx restart

# Last minute config changes
sed -i "s/localhost/${ENV_HOSTNAME}/g" /home/foundry/data/Config/options.json

runuser -l foundry -c "node /home/foundry/foundry/resources/app/main.js --dataPath=/home/foundry/data"