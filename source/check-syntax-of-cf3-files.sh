#!/bin/sh

# check syntax of all cf3 files


> cf-syntax-check-failed.txt  # zero out the file

for f in $(ls *cf | grep -v SKIP)
do
  sudo cf-promises -f ./$f
  if [ $? != 0 ]; then echo $f >> cf-syntax-check-failed.txt; fi
done
