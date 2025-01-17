#!/usr/bin/env bash
# This Bash script sets up my web servers for the deployment of web_static

apt-get -y update > /dev/null
apt-get install -y nginx > /dev/null

# Creating all the necessary directories and files
mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
touch /data/web_static/releases/test/index.html
echo "Holberton School" > /data/web_static/releases/test/index.html

# Checking if directory current exist
if [ -d "/data/web_static/current" ]
then
        sudo rm -rf /data/web_static/current
fi
# Creating a symbolic link to test
ln -sf /data/web_static/releases/test/ /data/web_static/current

# Changing ownership to user ubuntu
chown -hR ubuntu:ubuntu /data

# Configuring nginx to serve content pointed to by symbolic link to hbnb_static
sed -i '38i\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

# Restart server
service nginx restart
