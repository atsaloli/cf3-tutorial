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
  clear
  filename=$(grep -m1 "^$1 " index.txt | awk '{print $2}')
  echo "Showing [$slide_number/$total_slides] $filename"

  if [[ $filename =~ \.exr.md$ ]]
  then
    # insert Exercise header for in-class presentation
    # works around https://github.com/ttscoff/mdless/issues/60
    echo '### Exercise'
    echo
    cat "$filename";
  elif [[ $filename =~ \.md$ ]]; then
    cat "$filename"
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
		+) ((slide_number=slide_number+10)); showfile "$slide_number" ;;
		'-') ((slide_number=slide_number-10)); showfile "$slide_number" ;;
        *) get_keystroke ;; # bad input.  try again.



	esac
done

