Let's say you are scanning a logs directory, looking
for files to compress by age (i.e. performing a common
sysadmin task, compress files older than N days, and
remove compressed files older than Y weeks).

Here is the regex pattern to exclude gzipped files 
(files with .gz suffix) from your search for files
to compress but to include log files (files with "log"
in the name):


    ^(?!.*\.gz).*log.*

Let's test this out with pcregrep to make sure it filters
out gzipped files:

    # echo maillog | pcregrep '^(?!.*\.gz).*log.*'
    maillog
    # echo maillog.gz | pcregrep '^(?!.*\.gz).*log.*'
    #

Yep, it sure does!
