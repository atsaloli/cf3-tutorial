#!/bin/sh

# Demonstrate how CFEngine truncates names of long
# commands.
#
# Create an executable with a long path name - we'll need
# it for the next example.

LONG_PATH=/usr/local/sbin/a/really/long/path/to
sudo /bin/mkdir  -p ${LONG_PATH}
sudo /bin/cp -p /bin/echo ${LONG_PATH} >/dev/null
ls -l /bin/echo ${LONG_PATH}/echo
