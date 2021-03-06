#!/bin/sh

# See also: run_cf3_slides.sh


# Purpose: show cfengine examples using vim.  This allows us
# to edit the examples during the presentation.

# Hints:
# - run configure_vm.sh first to install required packages
# - use latest Vim (built from source) to get the best Vim Terminal

# start slideshow (using latest version of Vim)
# vim `ls -1 | egrep -v '.png$|.pdf$|.skip$|BOOKONLY' `

## Updated January 2021
## Actually, now I prefer to use this shell script instead:
. ./shell_slideshow.sh
