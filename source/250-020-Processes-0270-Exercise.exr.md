Kill a process

Start print services:

  yum install cups
  /etc/init.d/cups start

Write and run a promise to signal TERM and KILL to the cupsd process


WARNING: add example here

 processes:

    "^root\s+\d+\s+\d+\s+\d+\s+[89][0-9]\..*splunkd"

      comment => "Restart splunk if it's using more than 80% of the CPU.
                  A restart seems to
                  clear it up.",
      process_stop => "/opt/splunkforwarder/bin/splunk restart";

Add ps command line and how to find it.


