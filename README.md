# cf3-tutorial

## Overview
This tutorial is built using the [Softcover](http://softcover.io/) book generation toolchain.

The source is in source/ and consists of many little numbered files that are used in the in-class "vim slideshow" (delivered by run_slides.sh)

source/build_softcover.sh builds the Softcover Markdown files (in chapters/) from the files in source/

So the overall flow is:

source/  ->  chapters/   ->  html/


## Instructions

There are four ways to access the materials:

1. View the HTML on www.cfenginetutorial.org

2. Run the "l.sh" script in the source directory: this will show all
the source files for the book, in sequence, with color highlighting and
indentation to indicate chapter/section/subsection etc.

3. Run "install_vim_slideshow_bindings.sh" and then "run_slides.sh" --
this is what I use when teaching.

Key bindings: 
press F7 to move to the next slide,
Backspace to go to the previous slide,
"ff" to feed the file to cf-agent,
"vv" to do so in verbose mode,
"rr" to run shell scripts, etc. (see install_vim_slideshow_bindings.sh" for detail).

4. Build the book HTML using the build_softcover.sh script in the
"source" directory.
This requires SoftCover from www.softcover.io
Then look at html/cf3.html 


## Say hello
Email @atsaloli if you have any questions or to say hello
