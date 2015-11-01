#!/bin/sh

# demonstrate handling of multi-line output

# Create an executable with a long path name - we'll need
# it for the next example

LONG_PATH=/usr/local/sbin/a/really/long/path/to
/bin/mkdir  -p ${LONG_PATH}
/bin/cp -p /usr/bin/printf ${LONG_PATH}/printf >/dev/null
ls -l /usr/bin/printf ${LONG_PATH}/printf
