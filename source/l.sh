#!/bin/sh

# colorize "ls" output to read the table of contents for the course materials.  
# differentiate chapter numberting from section numbering from section titles;
# highlight in red file names that do not match expected pattern.
# Aleksey Tsalolikhin

install_remark() {
  echo
  echo
  echo Installing regex-markup to provide colorization and markup of output

  if [ -f /bin/rpm ]
  then
          sh -x -c 'wget http://download.savannah.gnu.org/releases/regex-markup/regex-markup-0.10.0-1.x86_64.rpm' && sudo rpm -ihv ./regex-markup-0.10.0-1.x86_64.rpm
  fi

  if [ -f /usr/bin/dpkg ]
  then
	  sh -x -c 'wget  http://gnu.mirrors.pair.com/savannah/savannah/regex-markup/regex-markup_0.10.0-1_amd64.deb' && sudo dpkg -i ./regex-markup_0.10.0-1_amd64.deb
  fi

  echo press ENTER to continue; read A
}


# l.sh depends on "remark" which is provided by "regex-markup" from nongnu.org.
# let's check that "remark" is installed, and if it's not, then install it

command -v remark >/dev/null 2>&1 || install_remark


# display a colorized file list, in alphanumeric order

ls -1F| \
  remark ./VSAcf3.remark | \
  less -r  # the -r switch preserves colorization
