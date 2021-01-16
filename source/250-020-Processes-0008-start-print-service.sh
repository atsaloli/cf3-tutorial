#!/bin/bash

# Install and start CUPS (print service), so we can
# setup for using CFEngine to disable CUPS

yum install -y cups
service cups start
ps -ef | grep cupsd
