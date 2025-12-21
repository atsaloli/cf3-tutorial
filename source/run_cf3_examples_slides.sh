#!/bin/bash
# start slideshow -- show CF3 files only (to review examples)
vim $( ls -1 | egrep -v '.png$|.pdf$|.skip$|BOOKONLY' | grep '.cf$' )
