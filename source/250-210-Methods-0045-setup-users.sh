#!/bin/sh

set -x  # show us each command after expanding it,
        # so we can see what commands are being run

# Add a couple of users and a crontab to set up for the next example

sudo useradd alex
sudo useradd rob

# Create a crontab for user "alex"
EDITOR="/bin/echo @daily /bin/echo hello world > " sudo crontab -e -u alex

sudo crontab -l -u alex
