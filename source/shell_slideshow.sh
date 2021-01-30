#!/bin/bash
buildindex(){
	# build an index of the files that we are going to present in class
	# we'll use the number to move forward and backward
	# (like an array key)
	 ls -1 | egrep -v '.png$|.pdf$|.skip$|BOOKONLY' |
		 nl --number-format=ln > index.txt
     total_slides=$(cat index.txt | wc -l)
}

showfile(){
  # Display a file

  # Look up filename from slide_number index
  filename=$(grep -m1 "^$1 " index.txt | awk '{print $2}')

  # Prepare the content for the slideshow header message (the first row)
  status_line="[$slide_number/$total_slides] $filename"

  # Print filename in a reverse video bar across the 1st row
  clear
  cols=$(tput cols) # Get the number of columns for the current terminal.
  tput rev # start reverse video
  printf "%-${cols}s" "$status_line"
  tput sgr0 # turn off all attributes
  echo
  #echo '---------------------------------------------------------------------'

  if [[ $filename =~ \.md$ ]]; then
	  /opt/git/cf3-tutorial/source/mdless-wrapper.sh $filename
  elif [[ $filename =~ \.cf$ ]]; then
    pygmentize -l cfengine3 "$filename"
  elif [[ $filename =~ \.sh$ ]]; then
    pygmentize -l shell "$filename"
  elif [[ $filename =~ \.json$ ]]; then
    pygmentize -l json "$filename"
  fi
}

edit_file(){
	# edit a file
	# note :the filename logic is duplicated in showfile()
  filename=$(grep -m1 "^$1 " index.txt | awk '{print $2}')
  vim "$filename"
}

run_file(){
	# edit a file
	# note :the filename logic is duplicated in showfile() and edit_file()
    filename=$(grep -m1 "^$1 " index.txt | awk '{print $2}')
    clear
    [[ $filename =~ \.cf$ ]] &&
		command="/var/cfengine/bin/cf-agent --color=always -KI -f /opt/git/cf3-tutorial/source/$filename"
    [[ $filename =~ \.sh$ ]] &&
		command="/bin/sh /opt/git/cf3-tutorial/source/$filename"
	echo "+ ${command}"
	echo
	sudo $command
}

#" feed file to cf-agent in Verbose mode
#map vv :!clear;sudo /var/cfengine/bin/cf-agent --color=always -KIv -f '#:p' \| less -R^M

get_keystroke(){
	# read 1 keystroke. This populates $REPLY.
	stty -echo  # turn off echoing of input
	read -d'' -s -n1
	stty echo  # turn echoing of input back on
	ascii_representation_of_keystroke=$(echo -n "$REPLY" 2>/dev/null |
		od -a 2>/dev/null |
		awk '{print $2}')  # for subsequent comparison; this will
			               # convert special characters like DEL into an
						   # ascii representation ("del")

}

###################################################################################

buildindex

slide_number=1  # initialize counter. this tells us where we are in the
                # slide index.
showfile 1

while true
do
	get_keystroke
	case "${ascii_representation_of_keystroke}" in
		q) exit ;;  # Quit
		sp) (( slide_number=slide_number+1 )); showfile "$slide_number" ;; # SPACE = go Forward
		b|del) (( slide_number=slide_number-1 )); showfile "$slide_number" ;; # DEL (or "b") = go Back
		e) edit_file "$slide_number"; showfile "$slide_number" ;;
        f|r) run_file "$slide_number" ;; # Run the file (with cf-agent or bash)
        v) verbose_run_file "$slide_number" ;; # Run the file (with cf-agent -v)
        !) bash; showfile "$slide_number" ;; # shell out
		+) ((slide_number=slide_number+10)); showfile "$slide_number" ;;
		\-) ((slide_number=slide_number-10)); showfile "$slide_number"
			;; ## this doesn't work for some reason (patterns). TODO fix it
		B) ((slide_number=slide_number-10)); showfile "$slide_number" ;;
		## go Back 10 slides
        *) get_keystroke ;; # bad input.  try again.



	esac
done

