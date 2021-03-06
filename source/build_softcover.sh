#!/bin/bash

# TODO: update Book.txt with the book parts (cfengine_NNN.md)


#### Variables

_DEBUG="on"
_DEBUG="off"
# flip the order of the above two lines to enable or disable debug print statements

SOFTCOVER_BASE=~/git/cf3-tutorial
cd $SOFTCOVER_BASE/source

output_target=z_cfengine_essentials

#### Functions

function DEBUG() {
	 [ "$_DEBUG" == "on" ] &&  $@
}

function process_files(){

### initialize environment
rm -rf /tmp/mod_files/
mkdir  /tmp/mod_files/

# delete book parts, these will be recreated
# by concatenate_sc function
rm $SOFTCOVER_BASE/chapters/cfengine_???.md


EXERCISE_COUNTER=1

### Get list of source files. Sort
find . -maxdepth 1 -type f -iname "[0-9]*.md" \
                        -o -iname "[0-9]*.cf" \
                        -o -iname "[0-9]*.pl" \
                        -o -iname "[0-9]*.sh" \
                        -o -iname "[0-9]*.json" \
                        -o -iname "[0-9]*.mustache" \
  | sort > /tmp/file_list.txt

### Begin Work
for file in `cat /tmp/file_list.txt`
do
	AT_part=`echo ${file^} | awk -F"-" '{print $1}' | sed "s/_/ /g"`
	chapter=`echo ${file^} | awk -F"-" '{print $3}' | sed "s/_/ /g"`
	worda=( $(IFS=._- ; printf '%s ' $chapter) )
	chapter=${worda[@]^}
	section=`echo ${file^} | awk -F"-" '{print $5}' |  awk -F"." '{print $1}' | sed "s/_/ /g"`
	wordb=( $(IFS=._- ; printf '%s ' $section) )
	section=${wordb[@]^}

        DEBUG echo
        DEBUG echo AT_part = $AT_part
        DEBUG echo file = $file
        DEBUG echo chapter = $chapter
        DEBUG echo section = $section
        DEBUG echo

        #LOOP_COUNTER=`expr $LOOP_COUNTER + 1`
        #if [ $LOOP_COUNTER -gt $THRESHOLD ]; then
        #   DEBUG echo Target reached. Moving on...  >&2
        #fi

        #DEBUG echo $file $LOOP_COUNTER

# Regex in Bash creates an array BASH_REMATCH for back-references
# if [[ "452MATCHME" =~ ^([0-9]+).* ]]
# then 
    # echo ${BASH_REMATCH[1]};
# fi

if [[ "${file}" =~ SKIP|skip|CLASSONLY ]]; then
  filetype=skip;
elif [[ "${file}" =~ cf$ ]]; then
  filetype=cfengine3
elif [[ "${file}" =~ exr.md$ ]]; then
  filetype=exercise
  # Exercise files, in case we want to do
  # something special with them later,
  # such as build an index of exercises
elif [[ "${file}" =~ md$ ]]; then
  filetype=markdown
elif [[ "${file}" =~ mustache$ ]]; then
  filetype=text # no syntax highlighting in pygments for mustache yet
elif [[ "${file}" =~ pl$ ]]; then
  filetype=perl
elif [[ "${file}" =~ json$ ]]; then
  filetype=json
elif [[ "${file}" =~ sh$ ]]; then
  filetype=bash
elif [ -z ${filetype} ]; then
  echo $file is an unknown filetype, aborting
  exit 1
fi

DEBUG echo "$file is a $filetype file."
#echo press any key to continue; read A

target="/tmp/mod_files/$file"
DEBUG echo target = ${target}

# strip off the leading ./ in the filename
# and then escape underscores in the filename
# or else softcover will swallow them
filename=`echo ${file} | sed -e 's:^\./::' -e 's:_:\\\_:g' `
DEBUG echo file=$file filename=$filename.
               

### skip SKIP files
if [ "$filetype" == "skip" ];then
  DEBUG echo "skipping $file"
fi


### process Markdown files
if [ "$filetype" == "markdown" ];then
  echo                         >> $target	
  echo '<!---'                 >> $target  # embed source filename as a comment
  echo "Filename: ${filename}" >> $target  # so we can find it easily if we need
  echo '-->'                   >> $target  # to make changes
  echo                         >> $target	
  cat $file                    >> $target 
  echo                         >> $target 
  DEBUG echo '\coloredtext{red}{' ${filename} '}' >>$target
  echo                         >> $target 
fi



### process exercise files
if [ "$filetype" == "exercise" ];then

  HEADING=`head -1 $file`
  cat <<EOF > $target
<!---                 
Filename: ${filename}
-->

\begin{aside}
\label{aside:exercise_${EXERCISE_COUNTER}}
\heading{${HEADING}}

EOF


  tail -n +2 $file             >> $target
  echo                         >> $target 
  echo                         >> $target 
  echo '\end{aside}'           >> $target
  DEBUG echo '\coloredtext{red}{' ${filename} '}' >>$target
  EXERCISE_COUNTER=`expr $EXERCISE_COUNTER + 1`
fi


  ### process perl/cfengine3/bash/text files
  if [ "$filetype" == "cfengine3" -o "$filetype" == "perl" -o "$filetype" == "bash" -o "$filetype" == "text" ];then
  		
  cat <<EOF >> $target
\begin{codelisting}
\codecaption{${filename}}
\`\`\`${filetype}, options: "linenos": false
EOF
  cat $file >> $target
  cat <<EOF >> $target
\`\`\`
\end{codelisting}
EOF
  fi
  
### end main loop
done
}

#########################################
### Create single Softcover markdown formatted file

function concatenate_sc() {

SOFTCOVER_CHAPTER_COUNTER=1

echo entering concatenate_sc function
for file in `find /tmp/mod_files/* -maxdepth 1 -type f -iname "[0-9]*[cf|txt|md|pl|json|mustache|sh|exr]" |
  sort`
	do
               echo processing $file for concatenation
	       book_part=`echo ${file^} | sed -e s:/tmp/mod_files/:: | awk -F"-" '{print $1}' | sed "s/_/ /g"`
               # concatenate files into one file per book part (to get softcover to build)
               DEBUG echo book_part = $book_part

	       cat $file >> cfengine_${book_part}.md
	done

echo exiting concatenate_sc function
}

generate_book_txt(){
# Builds a SoftCover Book.txt file which contains an entry for every chapter
# (Book.txt controls the structure of the book)
cat <<EOF > $SOFTCOVER_BASE/Book.txt
cover
frontmatter:
maketitle
tableofcontents
foreword.md
acknowledgements.md
abouttheauthor.md
copyrightandlicense.md
mainmatter:
EOF

ls $SOFTCOVER_BASE/chapters/ | grep ^cfengine_ >> $SOFTCOVER_BASE/Book.txt
}

##### End Functions


## Start Main Program ##
process_files && 
concatenate_sc

mv cfengine_???.md  $SOFTCOVER_BASE/chapters
cd $SOFTCOVER_BASE
generate_book_txt
softcover build:html

#if [ $? -eq 0 ] ; then
#firefox html/cfengine_tutorial.html &
#fi
