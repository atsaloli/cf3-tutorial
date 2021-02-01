#!/bin/sh

# check syntax of all cf3 files

for f in *cf
do
  sudo cf-promises -f ./$f
  if [ $? != 0 ]; then echo $f >> cf-syntax-check-failed.txt; fi
done
