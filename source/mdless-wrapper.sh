#!/bin/bash -e

#  mdless is a markdown to text converter: https://brettterpstra.com/projects/mdless/

# Here are some options for using mdless in in-class slideshow presentations

# plus truncate its output (workaround for https://github.com/ttscoff/mdless/issues/63)

if [[ $1 =~ \.exr.md$ ]]
then
  # insert Exercise header for in-class presentation
  # works around https://github.com/ttscoff/mdless/issues/60 
  echo '### Exercise'
  echo
  cat "$1";
else
  cat "$1"
fi  | /opt/git/.gem/bin/mdless --no-pager --width=100 | head -n -3 | tail -n +3
