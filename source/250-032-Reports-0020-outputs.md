When you run `cf-agent` on the command line, any reports or output generated by your promises go to STDOUT.

When `cf-execd` runs `cf-agent`, a copy of all output from `cf-agent`
is saved to /var/cfengine/outputs/ with a timestamp in the filename
and a symlink "previous" is updated to point at the most recent file.

`cf-execd` may additionally forward output to syslog and/or email it.
This is all configurable.

Let's demonstrate handling of agent outputs by editing /var/cfengine/masterfiles/services/main.cf
to add promises which generate output:

```cfengine3
###############################################################################
#
# bundle agent main
#  - User/Site policy entry
#
###############################################################################

bundle agent main
# User Defined Service Catalogue
{
  reports:
    "hello world";

  commands:
    "/bin/date";

  methods:
    # Activate your custom policies here
}
```

Now let's run the "update" policy to update our /var/cfengine/inputs/
directory from /var/cfengine/masterfiles/ :

```text
root@ubuntu:~# cf-agent -IC -f update.cf
    info: Updated '/var/cfengine/inputs/services/main.cf' from source
'/var/cfengine/masterfiles/services/main.cf' on 'localhost'
root@ubuntu:~# 
```

And let's verify that our promises generate output as expected by running `cf-agent` on the command line:

```text
root@ubuntu:~# cf-agent
  notice: Q: ".../bin/date": Sat Nov  7 21:18:41 PST 2015
R: hello world
root@ubuntu:~#
```

Wait up to five minutes for `cf-execd` to run `cf-agent` during the next scheduled run.
We know when it's done that by watching the promise summary log on the command line:

```bash
tail -f /var/cfengine/promise_summary.log
```

The promise summary log will contain outcomes for each run of `cf-agent`.  `cf-execd` will run `cf-agent` twice: first to update policy (update.cf) and then to evaluate the policy (promises.cf):

```text
root@ubuntu:~# tail -2 /var/cfengine/promise_summary.log
1446960991,1446960991: Outcome of version update.cf 3.7.1 (agent-0):
Promises observed -
Total promise compliance: 100% kept, 0% repaired, 0% not kept
  (out of 688 events).
User promise compliance: 100% kept, 0% repaired, 0% not kept
  (out of 7 events).
CFEngine system compliance: 100% kept, 0% repaired, 0% not kept
  (out of 681 events).
1446960991,1446960992: Outcome of version CFEngine Promises.cf 3.7.1 (agent-0):
Promises observed -
Total promise compliance: 100% kept, 0% repaired, 0% not kept
  (out of 4319 events).
User promise compliance: 97% kept, 3% repaired, 0% not kept
  (out of 37 events).
CFEngine system compliance: 100% kept, 0% repaired, 0% not kept
  (out of 4282 events).
root@ubuntu:~# 
```

I added linebreaks to the above output to make it more readable and to make it fit on the page.  It's really just two lines.

You can convert the timestamps in promise_summary.log to human-readable with `date -d @<timestamp>`:

```text
root@ubuntu:~# tail -1 /var/cfengine/promise_summary.log
1446960991,1446960992: Outcome of version CFEngine Promises.cf 3.7.1 (agent-0):
Promises observed - Total promise compliance: 100% kept, 0% repaired, 0% not kept
  (out of 4319 events).
User promise compliance: 97% kept, 3% repaired, 0% not kept
  (out of 37 events).
CFEngine system compliance: 100% kept, 0% repaired, 0% not kept
  (out of 4282 events).
root@ubuntu:~# date -d @1446960991 ; date -d @1446960992
Sat Nov  7 21:36:31 PST 2015
Sat Nov  7 21:36:32 PST 2015
root@ubuntu:~# 
```

There are two timestamps: start and end times of the `cf-agent` run.  The delta is how long the agent took to run.

Finally, let's check the output from the previous run of `cf-agent`:

```text
root@ubuntu:/var/cfengine/outputs# cat previous
  notice: Q: ".../bin/date": Sat Nov  7 21:21:26 PST 2015
R: hello world
root@ubuntu:/var/cfengine/outputs#
```

CFEngine saves outputs from prior runs and just updates the "previous"
symlink to point at the most recent run:

```text
root@ubuntu:/var/cfengine/outputs# ls -ltrh1 | tail -5
-rw------- 1 root root   73 Nov  7 21:51 
  cf_ubuntu__1446961897_Sat_Nov__7_21_51_37_2015_0x7fc6436dd700
-rw------- 1 root root   73 Nov  7 21:56
  cf_ubuntu__1446962199_Sat_Nov__7_21_56_39_2015_0x7fc6436dd700
-rw------- 1 root root   73 Nov  7 22:01
  cf_ubuntu__1446962501_Sat_Nov__7_22_01_41_2015_0x7fc6436dd700
lrwxrwxrwx 1 root root   83 Nov  7 22:06 previous ->
  cf_ubuntu__1446962804_Sat_Nov__7_22_06_44_2015_0x7fc6436dd700
-rw------- 1 root root   73 Nov  7 22:06
  cf_ubuntu__1446962804_Sat_Nov__7_22_06_44_2015_0x7fc6436dd700
root@ubuntu:/var/cfengine/outputs#
```

For example, let's look at today's outputs - there are two since
I created this example:

```text
root@ubuntu:/var/cfengine/outputs# more cf_ubuntu__144*Sat*Nov*
::::::::::::::
cf_ubuntu__1446960084_Sat_Nov__7_21_21_24_2015_0x7fc6436dd700
::::::::::::::
  notice: Q: ".../bin/date": Sat Nov  7 21:21:26 PST 2015
R: hello world
::::::::::::::
cf_ubuntu__1446960386_Sat_Nov__7_21_26_26_2015_0x7fc6436dd700
::::::::::::::
  notice: Q: ".../bin/date": Sat Nov  7 21:26:28 PST 2015
R: hello world
root@ubuntu:/var/cfengine/outputs# 
```

Now let's check /var/log/syslog:

```text
Nov  7 21:36:32 ubuntu [96961]: CFEngine(agent) 
  Q: ".../bin/date": Sat Nov  7 21:36:32 PST 2015

Nov  7 21:36:32 ubuntu [96961]: CFEngine(agent) 
  R: hello world

Nov  7 21:41:35 ubuntu [97148]: CFEngine(agent) 
  Q: ".../bin/date": Sat Nov  7 21:41:35 PST 2015

Nov  7 21:41:35 ubuntu [97148]: CFEngine(agent) 
  R: hello world

Nov  7 21:46:37 ubuntu [109436]: CFEngine(agent) 
  Q: ".../bin/date": Sat Nov  7 21:46:37 PST 2015

Nov  7 21:46:37 ubuntu [109436]: CFEngine(agent) 
  R: hello world
```

Notice that "reports" outputs are tagged with "R" and
quoted "commands" outputs are tagged with "Q".