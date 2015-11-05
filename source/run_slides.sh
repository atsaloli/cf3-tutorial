#!/bin/sh

# Purpose: show cfengine examples using vim.  This allows us
# to edit the examples during the presentation.


# working with the training collection requires the following packages:

for REQUIRED in asciidoc elinks vim elinks regex-markup
do
  # check if it is installed, and if not, install it
  command -v ${REQUIRED} >/dev/null 2>&1 || \
  (
     # try to guess the package mgr
     sudo yum install ${REQUIRED} 2>/dev/null  || sudo apt-get install ${REQUIRED} 2>/dev/null
  )
done

# pygments is used to colorize/syntax-highlight code
command -v pygmentize >/dev/null 2>&1 || sudo yum install python-pygments || sudo apt-get install python-pygments

# libreoffice-impress is used to display a presentation
command -v libreoffice >/dev/null 2>&1 || sudo yum install libreoffice-impress || sudo apt-get install libreoffice-impress

# start slideshow
vim `ls -1 | egrep -v '.png$|.pdf$|.skip$|BOOKONLY' `

