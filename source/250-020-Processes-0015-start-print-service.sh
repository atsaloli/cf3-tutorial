#!/bin/bash

# Install and start CUPS (print service), so we can
# practice using CFEngine to ensure a process ("cupsd")
# is absent.

sudo yum install -y cups
sudo service cups start
ps -ef | grep cupsd
