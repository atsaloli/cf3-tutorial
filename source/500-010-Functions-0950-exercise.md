Functions exercise

Print a report if /etc/motd is newer than /etc/passwd

---------------

How to convert epoch time to human-readable:

vars:
  "human_ctime"
     string => execresult("/bin/date -d @ $(ctime)", "noshell");

reports:
  "$(human_ctime)";

