#!/bin/bash

apt-get update -y
apt-get install -y nginx 
systemctl start nginx
systemctl enable nginx

echo "<h1>Automated Nginx App via Terraform</h1><p>By Lakshya Bhardwaj</p>" > /var/www/html/index.html