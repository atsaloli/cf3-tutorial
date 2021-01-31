cols=$(tput cols) # Get the number of columns for the current terminal.
tput rev # start reverse video
msg='hello world'
printf "%-${cols}s" "$msg"
tput sgr0 # turn ff all attributes

