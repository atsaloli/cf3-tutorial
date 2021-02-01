#!/bin/sh

sudo yum -y remove postgresql postgresql-server
sudo rm -rf /var/lib/pgsql
