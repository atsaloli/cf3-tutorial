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
  echo

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
		command="sudo /var/cfengine/bin/cf-agent -KI "$2" -f /opt/git/cf3-tutorial/source/$filename -C"
    [[ $filename =~ \.sh$ ]] &&
		command="sudo /bin/sh /opt/git/cf3-tutorial/source/$filename"
	echo "+ ${command}"
	echo
	$command
	echo
	echo Done
	read -d'' -s -n1 # get a single keystroke
	showfile "$slide_number" # redisplay the source code so we can fully understand what just happened
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

get_slide_number_input(){
# allow user to enter slide number to jump to
  printf %s '? '
  read slide_number
}

increment_slide_number(){
  (( slide_number=slide_number+1 ))
  echo $slide_number > slide_number.dat
}

decrement_slide_number(){
  (( slide_number=slide_number-1 ))
  echo $slide_number > slide_number.dat
}

###################################################################################

buildindex

if [ -f slide_number.dat ]; then
	slide_number=$(cat slide_number.dat)
	# read in the
	# slide number (from earlier runs of shell_slideshow.sh, this allows
	# us to resume in the slidedeck on the following day, for example).
	#
	# input validation
	if ! [[ $slide_number =~ ^[0-9]+$ ]]; then
	   echo "Slide number '$slide_number' not numeric. Corrupt slide_number.dat?" >&2
	   exit 1
   fi
else
  slide_number=1  # initialize counter. this tells us where we are in the  slide index.
fi

showfile $slide_number

while true
do
	get_keystroke
	case "${ascii_representation_of_keystroke}" in
		q|Z) exit ;;  # Quit (the Z is because I tend to press ZZ because I think I'm in Vim)
		sp) increment_slide_number; showfile "$slide_number" ;; # SPACE = go Forward
		b|del) decrement_slide_number; showfile "$slide_number" ;; # DEL (or "b") = go Back
		e) edit_file "$slide_number"; showfile "$slide_number" ;;
        f|r) run_file "$slide_number" ;; # Run the file (with cf-agent or bash)
        v) run_file "$slide_number" --verbose ;; # Run the file (with cf-agent -v)
        \#) get_slide_number_input; showfile "$slide_number" ;; # enter slide number to jump to, and jump to it
        !) bash; showfile "$slide_number" ;; # shell out
		+) ((slide_number=slide_number+10)); echo "$slide_number" > slide_number.dat; showfile "$slide_number" ;;
		\-) ((slide_number=slide_number-10)); echo "$slide_number" > slide_number.dat; showfile "$slide_number" ;; ## this doesn't work for some reason (patterns). TODO fix it
		B) ((slide_number=slide_number-10)); echo "$slide_number" > slide_number.dat; showfile "$slide_number" ;;
		## go Back 10 slides
		R) buildindex; showfile "$slide_number" ;; # Re-index (as after
		# adding a slide)
        *) get_keystroke ;; # bad input.  try again.



	esac
done

