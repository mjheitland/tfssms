#!/bin/bash
yum install httpd -y
echo "Subnet: ${subnet}" >> /var/www/html/index.html
service httpd start
chkconfig httpd on
