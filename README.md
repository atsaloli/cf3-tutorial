# cf3-tutorial

## Overview
This tutorial is built using the [Softcover](http://softcover.io/) book generation toolchain.

The source is in [source/](source/) and consists of many little numbered files that are presented in the numbered sequence during class using a ["vim slideshow"](source/run_slides.sh). There is also [another slideshow](source/run_cf3_examples_slides.sh) which shows only the CFEngine examples (I use this to review the examples).
 
[source/build_softcover.sh](source/build_softcover.sh) builds the Softcover Markdown files in [chapters/](chapters/) from the files in `source/` and thenb uses the [Softcover](https://github.com/softcover/softcover) gem to convert Softcover Markdown to HTML.

So the overall flow is:

`source/`  -->  `chapters/`   -->  `html/`


## Instructions

There are four ways to access the materials:

1. View the HTML on www.cfenginetutorial.org

2. Run the [l.sh](source/l.sh) script in the source directory: this will show all
the source files for the book, in sequence, with color highlighting and
indentation to indicate chapter/section/subsection etc.

3. Run [install_vim_slideshow_bindings.sh](source/install_vim_slideshow_bindings.sh) and then `run_slides.sh` --
this is what I use when teaching.

Key bindings for the vim slideshow:
- `SPACE` or `F7` to move to the next slide,
- `BACKSPACE` to go to the previous slide,
- `ff` to feed the file to cf-agent,
- `vv` to do so in verbose mode,
- `rr` to run shell scripts, etc. (see [install_vim_slideshow_bindings.sh](source/install_vim_slideshow_bindings.sh) for detail).

4. Build the book HTML using the [build_softcover.sh](source/build_softcover.sh) script, then look at html/cf3.html. See also the [GitHub Actions build-and-deploy workflow](.github/workflows/build-and-deploy.yml) which automates the build and deploy process - it lists out dependencies for the build script.

## Say hello
Email @atsaloli if you have any questions or to say hello.
