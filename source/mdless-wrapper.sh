#!/bin/sh

#  mdless is a markdown to text converter: https://brettterpstra.com/projects/mdless/

# Here are some options for using mdless in in-class slideshow presentations

# plus truncate its output (workaround for https://github.com/ttscoff/mdless/issues/63)

 mdless --no-pager --width=100 "$1" | head -n -3

