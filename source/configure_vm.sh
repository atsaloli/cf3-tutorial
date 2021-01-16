#!/bin/bash

die(){
  echo "$*"
  exit 1
}

# working with the training collection requires the following packages:

for required_package in git wget
do
  # check if it is installed, and if not, install it
  command -v ${required_package} >/dev/null 2>&1 || \
  (
     # try to guess the package mgr
     sudo yum install -y ${required_package} 2>/dev/null  || sudo apt-get install -y ${required_package} 2>/dev/null
  )
done

# pygments is used to colorize/syntax-highlight code
command -v pygmentize >/dev/null 2>&1 || sudo yum install -y python3-pygments || sudo apt-get install -y python-pygments

# also install ruby 2.6 (or newer) and then "gem install mdless" to install markdown->text converter
# make sure "pygmentize -L | grep cf3" shows CFEngine is installed
pygmentize -L | grep -q cf3 || die "'pygmentize -L' does not show cf3 (cfengine language support)"
