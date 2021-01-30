This order is _very_ intentional and is _not_ configurable.

Variables are evaluated first as they may be used in other promises.

Files are handled before Processes as one may want to configure a service
and then launch the daemon.

Processes come before Commands as one may want to run a command to start
or stop a service depending on whether the process is running.

Reports come last so that the reports are not immediately made out of
date (in other words, reports are last so that CFEngine doesn't report
something and then changes it).

This is called Normal Ordering.

Reference: [Normal
Ordering](https://docs.cfengine.com/latest/guide-language-concepts-normal-ordering.html)
