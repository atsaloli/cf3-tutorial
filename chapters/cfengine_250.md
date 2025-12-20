
<!---
Filename: 250-000-Part-Title-0000-Basic\_Promises.md
-->

# Basic Promises



<!---
Filename: 250-010-Files-0000-Chapter-Title.md
-->

## Files

File operations fall basically into three categories: create, delete and edit.

Set the `create` attribute to `true` and CFEngine will create the file if it does not exist.


\begin{codelisting}
\codecaption{250-010-Files-0210-Create\_a\_file.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  files:
      "/etc/nologin"
        handle => "touch_etc_nologin",
        comment => "Quiesce the system for maintenance",
        create  => "true";
}
```
\end{codelisting}

<!---
Filename: 250-010-Files-0215-touch\_a\_file.md
-->

The `touch` attribute tells CFEngine to touch (update) the timestamp on the file.


\begin{codelisting}
\codecaption{250-010-Files-0220-Touch\_a\_file.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  files:

      "/var/cfengine/i_am_alive"

        comment => "Update heartbeat timestamp (mtime)
                          to confirm CFEngine is running",
        create  => "true",
        touch   => "true";
}
```
\end{codelisting}
<!---                 
Filename: 250-010-Files-0230-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_9}
\heading{Create a file}


Write and run a policy promising that `/etc/ftp.deny` is present to
stop FTP users from logging in.




\end{aside}

<!---
Filename: 250-020-Processes-0000-Chapter-Title.md
-->

## Processes

Processes promises refer to items in the system process table.

CFEngine uses the output from the `ps` command to inspect running
processes.

In `processes:` promises, the promiser objects are patterns that are
_unanchored_, meaning that they match parts of command lines in the
system process table.

CEFngine uses libpcre to handle pattern-matching (regular expressions).

Reference:
- [PCRE - Perl Compatible Regular Expressions](https://www.pcre.org/)



<!---
Filename: 250-020-Processes-0005-what\_processes\_promises\_can\_do.md
-->

### What processes promises can do

* You can promise that a pattern be **present** to ensure a process is
running, such as `snmpd` for monitoring or `adclient` for using Active
Directory;

* to be **absent** (you can run a command to stop a process or you can
signal it, e.g., `TERM` or `KILL`);

* or you can **make decisions** based on your findings (such as restarting
a process when memory size grows past a limit).

Recap: You can use `processes:` promises to manage system processes.



<!---
Filename: 250-020-Processes-0010-ps\_options.md
-->

### "/bin/ps" options

My students sometimes ask what options CFEngine uses when it runs
`/bin/ps`, since `/bin/ps` can be different based on UNIX/Linux system
flavor.

CFEngine encapsulates the knowledge of how to administer various types
of UNIX-like systems, including the various `/bin/ps` options (of even if
`ps` is in another path); see
<https://github.com/cfengine/core/blob/0e5e8c52ba2779db3b8b9573c2b6abb807528df7/libpromises/systype.c#L95-L124>

You can also run CFEngine agent in **verbose mode** and it'll tell you
_how_ it's observing the process table.


\begin{codelisting}
\codecaption{250-020-Processes-0015-start-print-service.sh}
```bash, options: "linenos": false
#!/bin/bash

# Install and start CUPS (print service), so we can
# practice using CFEngine to ensure a process ("cupsd")
# is absent.

sudo yum install -y cups
sudo service cups start
ps -ef | grep cupsd | grep -v grep
```
\end{codelisting}

<!---
Filename: 250-020-Processes-0020-processes\_attributes\_signals.md
-->

### signals

Description: A list of menu options representing signals to be sent to a process.

Signals are presented as an ordered list to the process. On Windows, only the kill signal is supported, which terminates the process.

Type: (option list)

Allowed input range:

- hup
- int
- trap
- kill
- pipe
- cont
- abrt
- stop
- quit
- term
- child
- usr1
- usr2
- bus
- segv

Reference: <https://docs.cfengine.com/latest/reference-promise-types-processes.html#process_stop>


\begin{codelisting}
\codecaption{250-020-Processes-0025-Terminating\_a\_process.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  processes:
      "cupsd"
        signals => { "term", "kill" };
}

```
\end{codelisting}

<!---
Filename: 250-020-Processes-0030-processes\_attributes\_process\_stop.md
-->

### process_stop

Description: A command used to stop a running process

As an alternative to sending a termination or kill signal to a process, one may call a 'stop script' to perform a graceful shutdown.

Type: string

Allowed input range: "?(/.*)

Example:


```cfengine3
  processes:

      "cupsd"

        process_stop => "/sbin/service cups stop";
```

Reference: <https://docs.cfengine.com/docs/3.17/reference-promise-types-processes.html#process_stop>


\begin{codelisting}
\codecaption{250-020-Processes-0040-restart-print-service.sh}
```bash, options: "linenos": false
#!/bin/bash

# Check if print services daemon is running

ps -ef | grep cupsd | grep -v grep
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-020-Processes-0050-Stopping\_A\_Process\_Gracefully.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  processes:
      "cupsd"
        comment => "Shutdown print service",
        process_stop => "/sbin/service cups stop";
}
```
\end{codelisting}

<!---
Filename: 250-020-Processes-0255-Definition\_scalar.md
-->

### Note on Syntax: Single Values vs Lists

Definitions

**scalar**
: (programming) Any data type that stores a single value (e.g. a number or Boolean), as opposed to an aggregate data type that has many elements. A string is regarded as a scalar in some languages (e.g. Perl)  --- Free On-Line Dictionary of Computing

In CFEngine syntax, scalar values are enclosed in double quotes (or single quotes or backticks):

```cfengine3
process_stop => "/etc/init.d/cups stop",
```

Would you like to know more? See [Quoting](https://docs.cfengine.com/latest/reference-language-concepts-variables.html#quoting)


<!---                 
Filename: 250-020-Processes-0256-scalar.exr.md
-->

\begin{aside}
\label{aside:exercise_10}
\heading{Point out the scalar values in the following CFEngine policy.}


```cfengine3
bundle agent main
{
  processes:

      "cupsd"

        comment => "Shutdown print service",
        process_stop => "/sbin/service cups stop";

}
```


\end{aside}

<!---
Filename: 250-020-Processes-0257-Definition\_list.md
-->

**list**
: A data structure holding many values --- Free On-Line Dictionary of Computing

In CFEngine syntax, lists are in curly braces and
are a collection of comma-separated scalar values.
For example:

```cfengine3
processes:
    "cupsd"
        signals => { "term", "kill" };
```


<!---                 
Filename: 250-020-Processes-0270-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_11}
\heading{Kill a process}


Start print services manually (e.g., `yum install -y cups; service cups
start`) and then write and run a promise to signal the `cupsd` process
TERM and KILL

Don't copy and paste, type it yourself.

And try to do it from memory.  (Okay to look back if you need to.)

Note: signal name values in CFEngine are in lower-case and CFEngine
is case-sensitive.

Reference:
<https://docs.cfengine.com/docs/3.12/reference-promise-types-processes.html#signals>

What happens if you give CFEngine a right-hand side value (signal name)
that it doesn't recognize? What error message do you get? What does it
mean?





\end{aside}

<!---
Filename: 250-030-Commands-0000-Chapter-Title.md
-->

## Commands

Commands promises are promises to execute a command.


\begin{codelisting}
\codecaption{250-030-Commands-0290-date.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  commands:
      "/bin/date"
        comment => "Demonstrate a simple commands promise";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-030-Commands-0295-echo\_hello\_world.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  commands:
      "/bin/echo Hello, World!"
        comment => "Demonstrate a command with arguments (in promiser)";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-030-Commands-0300-echo\_hello\_world.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  commands:
      "/bin/echo"
        comment => "Sometimes it is convenient to separate command
                    and arguments.",
        args => "Hello, World!";
}

# Reference:
# https://docs.cfengine.com/latest/reference-promise-types-commands.html#args
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-030-Commands-0310-Relative\_path\_does\_not\_work.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  commands:
      "echo"
        args => "Hello world",
        comment => "Relative path does not work.";
}

```
\end{codelisting}
\begin{codelisting}
\codecaption{250-030-Commands-0320-Dig\_a\_deep\_hole.sh}
```bash, options: "linenos": false
#!/bin/sh

# Demonstrate how CFEngine truncates names of long
# commands.
#
# Create an executable with a long path name - we'll need
# it for the next example.

LONG_PATH=/usr/local/sbin/a/really/long/path/to
sudo /bin/mkdir  -p ${LONG_PATH}
sudo /bin/cp -p /bin/echo ${LONG_PATH} >/dev/null
sudo ls -l /bin/echo ${LONG_PATH}/echo
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-030-Commands-0330-command\_name\_truncation.cf}
```cfengine3, options: "linenos": false
# demonstrate handling of long command names in agent output

bundle agent main
{
  commands:
      "/usr/local/sbin/a/really/long/path/to/echo"
        args => "Hello, World!";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-030-Commands-0335-Quoted\_multiline\_output.cf}
```cfengine3, options: "linenos": false
# demonstrate handling of multi-line output

bundle agent main
{
  commands:
      "/usr/bin/printf"
        args => "%s\n%s\n%s\n One Two Three",
        comment => "Produce a multi-line command output";
}
```
\end{codelisting}

<!---
Filename: 250-032-Reports-0000-Chapter-Title.md
-->

## Reports

A `reports:` promise is a promise to output a report.

Reports output is prefixed with "R:" to indicate it is a report.



\begin{codelisting}
\codecaption{250-032-Reports-0010-hello\_world.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  reports:

      "Hello, World!";
}
```
\end{codelisting}

<!---
Filename: 250-032-Reports-0020-outputs.md
-->

### Handling of the output from reports promises

Where does the output from reports promises go?

When you run `cf-agent` on the command line, any reports or output
generated by your promises go to STDOUT.

When the executor daemon `cf-execd` runs `cf-agent`, a copy of all output
from `cf-agent` is saved to "/var/cfengine/outputs/" with a timestamp in
the filename. Additionally, a symlink "previous" is updated to point at
the most recent outputs file.

`cf-execd` may additionally forward output to syslog and/or email it.
This is all configurable.




<!---
Filename: 250-032-Reports-0030-outputs2.md
-->

#### Demonstration of handling reports: promises output

Let's demonstrate handling of agent outputs by editing
/var/cfengine/masterfiles/services/main.cf (the default
entry-point to our policy code base) to add promises which generate
output:

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



<!---
Filename: 250-032-Reports-0040-outputs3.md
-->

Now let's run the "update" policy to update our /var/cfengine/inputs/
directory from /var/cfengine/masterfiles/ :

```console
# cf-agent -IC -f update.cf
    info: Updated '/var/cfengine/inputs/services/main.cf' from source
'/var/cfengine/masterfiles/services/main.cf' on 'localhost'
# 
```




<!---
Filename: 250-032-Reports-0050-outputs4.md
-->

Verify that our promises generate output as expected by running `cf-agent` on the command line:

```console
# cf-agent
  notice: Q: ".../bin/date": Sat Nov  7 21:18:41 PST 2015
R: hello world
#
```




<!---
Filename: 250-032-Reports-0060-outputs5.md
-->

Wait 5-10 minutes for `cf-execd` to run `cf-agent` during the next scheduled run.
We know when it's done that by watching the promise summary log on the command line:

```console
tail -f /var/cfengine/promise_summary.log
```

The promise summary log contains outcomes for each run of `cf-agent`.




<!---
Filename: 250-032-Reports-0070-outputs6.md
-->

We expect to see two entries appear, as
`cf-execd` will run `cf-agent` twice: first to update policy (update.cf)
and then to evaluate the policy (promises.cf):


(I've inserted whitespace for readability, on the console you'd see two
lines only):

```console
1610932105,1610932105: Outcome of version update.cf 3.12.6 (agent-0):
  Promises observed to be kept 100.00%,
  Promises repaired 0.00%,
  Promises not repaired 0.00%
1610932105,1610932106: Outcome of version CFEngine Promises.cf 3.12.6 (agent-0):
  Promises observed to be kept 97.30%,
  Promises repaired 2.70%,
  Promises not repaired 0.00%
```

There are two comma-delimited timestamps (in UNIX epoch format) at the start of each line,
showing start and end of the `cf-agent` run.

You can convert the timestamps to human-readable with `date -d @<timestamp>`.

Subtract the start time from the end time to get how long the agent was running (in seconds).



<!---
Filename: 250-032-Reports-0080-outputs7.md
-->

Let's check the output from the previous run of `cf-agent`
in "/var/cfengine/outputs":

```console
# cat /var/cfengine/outputs/previous
  notice: Q: ".../bin/date": Sat Nov  7 21:21:26 PST 2015
R: hello world
#
```




<!---
Filename: 250-032-Reports-0090-outputs8.md
-->

##### Recap

The output from each agent run is in `/var/cfengine/outputs/`.

CFEngine updates the `previous` symlink to point at the most recent run.

`/var/cfengine/promise_summary.log` records _when_ the agent ran and and the _outcome summary_ for each run.



<!---
Filename: 250-032-Reports-0100-outputs9.md
-->

Now let's check syslog log file:

```console
# grep cf-agent /var/log/syslog | tail
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

Note: On Red Hat systems, check /var/log/messages.



<!---
Filename: 250-032-Reports-0110-outputs10.md
-->

Notice that "reports" outputs are tagged with "R" and
quoted "commands" outputs are tagged with "Q".

We are deluged with information in today's modern world; 
indicating what _type_ of data is being thrown at us
helps us to orient to what's happening and makes it
easier to assimilate the data.  This is a knowledge
management feature.



<!---
Filename: 250-040-Methods-0000-Chapter-Title.md
-->

## Methods

Methods are compound promises that refer to whole bundles of promises.

You can use them to group together related promises.

Example:

```cfengine3
bundle agent main
{
  methods:
      "base_os_config";  # configure the OS
      "application_config"; # and the application
}

bundle agent base_os_config { ... }

bundle agent application_config { ... }
```

We will learn more about `methods:` promises later.



<!---
Filename: 250-101-Scalars-0000-Chapter-Title.md
-->

## Variables

CFEngine variables can contain single values or collections of single
values (lists, arrays and data containers).



<!---
Filename: 250-101-Scalars-0005-scalars.md
-->

### Scalars



<!---
Filename: 250-101-Scalars-0010-intro.md
-->

Scalars

* A scalar is a single value.

* Each scalar may have one of three types: string, int or real.



<!---
Filename: 250-101-Scalars-0015-naming\_scalar\_vars.md
-->

### Identifying scalar variables

A scalar variable is represented as

```cfengine3
$(identifier)
```

Example:
```cfengine3
reports:
  "Hello, $(name)";
```



<!---
Filename: 250-101-Scalars-0016-braces\_mandatory.md
-->

The braces are mandatory. Braces help the parser know for sure when a
variable name ends so it doesn't have to guess if the variable name is
embedded in text:

```cfengine3
reports:
  "The product number is: $(machine_type)$(model)";
```

CFEngine doesn't like to guess about infrastructure.

Infrastructure is too important; we shouldn't be guessing about it.



<!---
Filename: 250-101-Scalars-0017-braces\_Make.md
-->

You can also use curly braces around scalar variables:

```cfengine3
  reports:
      "Hello, ${name}";
```

Round braces are Make-style; curly braces are UNIX shell style.

Either one will work.


\begin{codelisting}
\codecaption{250-101-Scalars-0018-scalar.cf}
```cfengine3, options: "linenos": false
# Here is an example of declaring and using a scalar variable
# of type string

bundle agent main
{
  vars:
      "name"
        string => "Inigo Montoya";

  reports:
      "Hello. My name is $(name).";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-101-Scalars-0020-Examples\_of\_scalar\_variables.cf}
```cfengine3, options: "linenos": false
# Examples of scalar variables.  One of each type:
# - string
# - integer
# - real number

bundle agent main
{
  vars:
      "my_string"      string  => "String contents...";
      "my_int" int => "42";
      "my_real" real    => "3.141592654";

  reports:
      "My string is: $(my_string)";
      "My integer is: $(my_int)";
      "My real number is: $(my_real)";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-101-Scalars-0170-typing.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  vars:
      "my_int"
        comment => "Try to assign a real number to an integer",
        int => "1.5";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-101-Scalars-0180-typing\_2.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  vars:
      "my_int"
        comment => "Try to assign a string to an integer variable.",
        int => "hello world";

  reports:
      "my int is $(my_int)";
}
```
\end{codelisting}
<!---                 
Filename: 250-101-Scalars-0190-vars.exr.md
-->

\begin{aside}
\label{aside:exercise_12}
\heading{}



Make and use a variable.

Write a policy to set a variable called "first_name" and set the value
to your first name (whatever your name is)..

Then create a `reports:` promise to have CFEngine say hello using this
variable.

For example, the output for a student named John would be:

"R: Hello, John"



\end{aside}

<!---
Filename: 250-101-Scalars-0200-variable\_scope.md
-->

### Scope of variables

There is no scope.

All variables in CFEngine are globally accessible.

However, if you refer to a variable by `$(unqualified)`, then it is
assumed to belong to the current bundle. To access any other scalar
variable, you must qualify the name, using the name of the bundle in
which it is defined, `$(bundle_name.qualified)`.



<!---
Filename: 250-101-Scalars-0210-variable\_scope\_example.md
-->

#### Example 

Let's say the variable `first_name` is defined in the bundle `names`:

```cfengine3
bundle agent names
{
  vars:
      "first_name"
        string => "John";
}
```

Unqualified reference:

```cfengine3
reports: "Hello, $(first_name)";
```

Qualified reference:

```cfengine3
reports: "Hello, $(names.first_name)";
```


\begin{codelisting}
\codecaption{250-101-Scalars-0410-Demo\_of\_variable\_scope.cf}
```cfengine3, options: "linenos": false
bundle agent main
{

  methods:
      "bundle_1";
      "bundle_2";
      "bundle_3";
}

bundle agent bundle_1 {
  vars: "first_name" string => "John";
  reports: "This works: Hello, $(first_name)";
}

bundle agent bundle_2 {
  reports: "But this doesn't: Hello, $(first_name)";
}

bundle agent bundle_3 {
  reports: "Qualified works: Hello, $(bundle_1.first_name)";
}
```
\end{codelisting}
<!---                 
Filename: 250-101-Scalars-0420-variable\_scope.exr.md
-->

\begin{aside}
\label{aside:exercise_13}
\heading{Declare a variable in one bundle and then use it from another bundle. }



\end{aside}

<!---
Filename: 250-101-Scalars-0430-namespace.md
-->

### Namespaces

To take this concept a step further, bundle and body names can be placed
in a namespace, allowing multiple files to define the bundles and bodies
with the same name in different namespaces without conflict. They are
key to writing self-contained, reusable, sharable policies.

Everything in CFEngine lives in a namespace (it's the `default` namespace
if not set).

Reference:
<https://docs.cfengine.com/latest/reference-language-concepts-namespaces.html#top>



<!---
Filename: 250-110-Integer\_Constants-0220-Special\_suffixes\_for\_Integer\_constants.md
-->

### A Note on Integer Variables: Integer-only Suffixes

Integer values may use suffixes to represent large numbers.

Which is easier to read?

* 200000
* 200k




<!---
Filename: 250-110-Integer\_Constants-0230-Special\_suffixes\_for\_Integer\_constants\_refcard.BOOKONLY.md
-->

#### Table of Integer Suffixes

| Suffix | Meaning                   |
|--------|---------------------------|
| `k` | value times {$$}1000{/$$}
| `m` | value times {$$}1000^2{/$$}
| `g` | value times {$$}1000^3{/$$}
| `K` | value times {$$}1024{/$$}
| `M` | value times {$$}1024^2{/$$}
| `G` | value times {$$}1024^3{/$$}
| `%` | meaning percent, in limited contexts
| `inf` | a constant representing an unlimited value


\begin{codelisting}
\codecaption{250-110-Integer\_Constants-0240-Integer\_suffixes\_demo.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  vars:
      "fourty_two_KILObytes" int => "42k";  # 42 x 1000
      "fourty_two_KIBIbytes" int => "42K";  # 42 x 1024

  reports:
      "42k (kilobytes) = $(fourty_two_KILObytes)";
      "42K (kibibytes) = $(fourty_two_KIBIbytes)";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-110-Integer\_Constants-0250-infinity.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  vars:
      "infinity" int => "inf";  # infinity

  reports:
      "infinity = $(infinity)";
}
```
\end{codelisting}

<!---
Filename: 250-110-Integer\_Constants-0300-scalars\_review.md
-->

### Review - Scalars

What are the three different types of scalar values in CFEngine?



<!---
Filename: 250-120-Lists-0000-Chapter-Title.md
-->

### List Variables

A list is a collection of scalars (single values).

A list variable is represented as `@(identifier)` or
`@(bundlename.identifier)`.

(Or using curly braces, UNIX shell-style, as with scalars.)



<!---
Filename: 250-120-Lists-0020-lists\_are\_typed.md
-->

#### List Types

Lists are typed:

- lists of strings,
- lists of integers,
- lists of reals.

The CFEngine language is typed because we don't like to guess about
infrastructure. Typing gives extra protection.



<!---
Filename: 250-120-Lists-0030-implicit\_looping.md
-->

#### Implicit Looping

If you refer to a list variable in scalar context by using `$(identifier)`,
CFEngine will implicitly loop over the values of `@(list)`.


\begin{codelisting}
\codecaption{250-120-Lists-0260-List\_variables\_and\_implicit\_looping.cf}
```cfengine3, options: "linenos": false
# Example of implicit looping

bundle agent main
{
  vars:
      "shopping_list"
        slist   => {
                     "apples",
                     "bananas",
                     "grapes",
                     "coconuts",
                     "hamburgers",
                   };

  reports:
      "Buy $(shopping_list)";
}

# Same as:
#
# #!/bin/sh
# for shopping_list in apples bananas grapes coconuts hamburgers
# do
#     echo Buy $shopping_list
# done
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-120-Lists-0270-implicit\_looping\_over\_an\_slist.cf}
```cfengine3, options: "linenos": false
# Notice how the parser handles @(my_slist) in scalar context -- not
# special!

bundle agent main
{
  vars:
      "shopping_list"
        slist   => {
                     "apples",
                     "bananas",
                     "grapes",
                     "coconuts",
                     "hamburgers",
                   };

  reports:
      "Iterating over @(shopping_list): Buy $(shopping_list)";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-120-Lists-0280-List\_variables\_Concatenation\_of\_slists.cf}
```cfengine3, options: "linenos": false
# However, if you refer to a @(list_variable) in _list_ context,
# it'll be treated as a variable (and expanded).

bundle agent main
{
  vars:
      "preface"
        string => "Now hear this: ";

      "main_body"
        slist => { "String contents...", "...are great!" };

      "the_sum_of_all_parts"
        slist => { $(preface), @(main_body) };
        # Demonstrate referring to a list as a complete collection
        # (without implicit looping)

  reports:
      "Iterating over list @(the_sum_of_all_parts): $(the_sum_of_all_parts)";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-120-Lists-0290-Lists\_of\_integers.cf}
```cfengine3, options: "linenos": false
# Demonstrate a list of integers (ilist)

bundle agent main
{
  vars:
      "my_list"
        ilist => { "1", "2", "3" };

  reports:
      "Iterating over the values in @(my_list):  $(my_list)";
      # Implicit looping works the same
}

```
\end{codelisting}
\begin{codelisting}
\codecaption{250-120-Lists-0300-Lists\_of\_real\_numbers.cf}
```cfengine3, options: "linenos": false
# Demonstrate an rlist (list of real numbers)

bundle agent main
{
  vars:
      "my_list"
        rlist => { "1.5", "3.0", "4.5" };

  reports:
      "Iterating over list: $(my_list)";
}
```
\end{codelisting}
<!---                 
Filename: 250-120-Lists-0310-exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_14}
\heading{Create a list variable containing names of five files to create.}


For example:

      /tmp/file1
      /tmp/file2
      /tmp/file3
      /tmp/file4
      /tmp/file5

Then use a single "files" promise to ensure all five files exist.

This is an example of Patterns + Promises = Configuration.

The list is a pattern (which parts of the infrastructure are affected).

The promise is to create a file.


\end{aside}
\begin{codelisting}
\codecaption{250-120-Lists-0320-nested\_loop.cf}
```cfengine3, options: "linenos": false
# Referring to an slist in scalar context implies looping.
#
# Set up a _nested_ implicit loop by referring to TWO
# slists in scalar context

bundle agent main
{
  vars:
      "fruit"
        slist => { "apples", "pears", "peaches" };

      "ways_to_prepare"
        slist => { "sliced", "boiled", "preserved" };

  reports:
      "I like to eat $(ways_to_prepare) $(fruit)";
}
```
\end{codelisting}

<!---
Filename: 250-130-Data\_Structures\_Arrays-0000-Chapter-Title.md
-->

### Arrays



<!---
Filename: 250-130-Data\_Structures\_Arrays-0010-Arrays\_arrays.md
-->

CFEngine arrays are associative (hashes).

They may contain scalars or lists as their elements.

Array variables are written with '[' and ']' brackets:

```cfengine3
$(array_name[key_name])
```

or

```cfengine3
$(bundle_name.array_name[key_name])
```




<!---
Filename: 250-130-Data\_Structures\_Arrays-0020-Arrays\_arrays2.md
-->

Example:

| Food    | Price |
|---------|-------|
| Apple   | 59c   |
| Banana  | 30c   |
| Oranges | 35c   |

Variable assignment:

```cfengine3
vars:
    "food_prices[Apple]"
      string =>  "59c";
```

Now we can use this variable:
```cfengine3
reports:
    "An apple costs $(food_prices[Apple])";
```




<!---
Filename: 250-130-Data\_Structures\_Arrays-0025-Arrays\_arrays3.md
-->

You can use curly braces, too:

```cfengine3
reports:
    "An apple costs ${food_prices[Apple]}";
```



\begin{codelisting}
\codecaption{250-130-Data\_Structures\_Arrays-0030-create\_array.cf}
```cfengine3, options: "linenos": false
# Example of creating an array and then pulling values out of it

bundle agent main
{
  vars:
      "food_prices[Apple]"
        string =>  "58c";

      "food_prices[Banana]"
        string =>  "30c";

  reports:
      "Apple costs $(food_prices[Apple])";
      "Banana costs $(food_prices[Banana])";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-130-Data\_Structures\_Arrays-0040-getindices.cf}
```cfengine3, options: "linenos": false
# The function getindices() returns an slist
# with the keys of an array
#
# Reference:
# https://docs.cfengine.com/latest/reference-functions-getindices.html

bundle agent main
{
  vars:
      "food_prices[Apple]"
        string =>  "58c";

      "food_prices[Banana]"
        string =>  "30c";

      "foods"
        slist => getindices("food_prices");

  reports:
      "Keys of 'food_prices' array: $(foods)";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-130-Data\_Structures\_Arrays-0050-array\_values.cf}
```cfengine3, options: "linenos": false
# Use the keys to retrieve the values

bundle agent main
{
  vars:
      "food_prices[Apple]"
        string => "58c";
      "food_prices[Banana]"
        string => "30c";
      "foods"
        slist => getindices("food_prices");

  reports:
      "Keys of 'food_prices' array: $(foods)";
      "Value of 'food_prices' array element with key '$(foods)' is: $(food_prices[$(foods)])";
}
```
\end{codelisting}
<!---                 
Filename: 250-130-Data\_Structures\_Arrays-0070-array.exr.md
-->

\begin{aside}
\label{aside:exercise_15}
\heading{Summary: Print array contents using getindices()}


1. Create an array with two things and their values.

e.g.

| Car | Cost |
|-----|------|
| BMW | 120K |
| Audi| 150K |

2. Report the contents of this array by using the `getindices()` function to
get a list of keys, and then iterate over the keys to output the values.


\end{aside}
\begin{codelisting}
\codecaption{250-130-Data\_Structures\_Arrays-0080-Arrays\_Keys\_are\_case\_senSiTiVE.cf}
```cfengine3, options: "linenos": false
# Note: Variable names, including array keys, are case-sensitive.

bundle agent main
{
  vars:
      "cfengine_components[cf-execd]"
        string => "The executor";

  reports:
      "$(cfengine_components[CF-exEcD])";
}
```
\end{codelisting}
<!---                 
Filename: 250-130-Data\_Structures\_Arrays-0100-Arrays.exr.md
-->

\begin{aside}
\label{aside:exercise_16}
\heading{Make an array, `student\_grades`.}


Populate it with the following data:

| Key   | Value    |
|-------|----------|
| Joe   | A |
| Mary  | A |
| Bob   | B |
| Sue   | B |

Display the contents of the array.


\end{aside}
\begin{codelisting}
\codecaption{250-130-Data\_Structures\_Arrays-0110-Arrays\_Array\_of\_slists.cf}
```cfengine3, options: "linenos": false
# An array can have elements of different types
#
# Reminder: If you refer to an slist in scalar context,
# CFEngine will loop over every element in the slist

bundle agent main
{
  vars:
      "config[my_string]"
        string =>  "hello world";

      "config[my_slist]"
        slist => { "one", "two" , "three" };

      "keys"
        slist => getindices("config");

  reports:
      "The value of 'config[$(keys)]' is: $(config[$(keys)])";
}
```
\end{codelisting}

<!---
Filename: 250-150-Data\_Structures\_Containers-0000-Chapter-Title.md
-->

### Data Containers

**Data container**
: A data container is a lot like a JSON document, it can be a key-value
map or an array or anything else allowed by the JSON standard with
unlimited nesting.

Example:

```json
{
  "Pizza": "Pepperoni",
  "Cities": [
    "London",
    "Paris",
    "Rome"
  ],
  "Games": {
    "Nintendo": [
      "Mario Bros",
      "Contra",
      "Zelda"
    ],
  }
}
```



\begin{codelisting}
\codecaption{250-150-Data\_Structures\_Containers-0010-example\_json\_container.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  vars:
      "food"
        data => '{
                   "Lunch"   : "Pizza",
                   "Dinner" : "Roast Beef"
                 }'; # JSON
      "keys"
        slist => getindices("food");

  reports:
      "$(keys) : $(food[$(keys)])";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-150-Data\_Structures\_Containers-0020-example\_yaml\_container.cf}
```cfengine3, options: "linenos": false
# You can represent data containers as YAML documents

bundle agent main
{
  vars:
      "food"
        data => '---
Lunch: Pizza
Dinner: Roast Beef'; # YAML

      "keys"
        slist => getindices("food");

  reports:
      "$(keys) : $(food[$(keys)])";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-150-Data\_Structures\_Containers-0030-format\_function.cf}
```cfengine3, options: "linenos": false
# The format() function, when used with a special format specifier %S,
# will pack the data container contents into a one-line string you can
# put into a log message, for example
#
# %S stands for "string"

bundle agent main
{
  vars:
      "food"
        data => '---
Lunch: Pizza
Dinner: Roast Beef';

      "data_contents"
        string => format("%S", "food");

  reports:
      "$(data_contents)";
}
```
\end{codelisting}

<!---
Filename: 250-150-Data\_Structures\_Containers-0040-readjson.md
-->

You can read in a JSON file with the CFEngine `readjson()` function:

```cfengine3
    vars:

     "loaded_data"
       data => readjson("/tmp/myfile.json", 40K);
```

The first argument is the filename.

The second argument is optional, maxbytes to read in.

Reference:
- [readjson](https://docs.cfengine.com/latest/reference-functions-readjson.html)
- [readyaml](https://docs.cfengine.com/latest/reference-functions-readyaml.html)






<!---                 
Filename: 250-150-Data\_Structures\_Containers-0050-readjson.exr.md
-->

\begin{aside}
\label{aside:exercise_17}
\heading{Data containers - readjson}


Manually create a JSON file, e.g., `phones.json`, with some phones/prices:

```json
{
  "iPhone"  : "$500",
  "Samsung" : "$450"
}
```

Read it into a data container with the `readjson()` function and report
the contents of the data container.



\end{aside}

<!---
Filename: 250-210-Methods-0000-Chapter-Title.md
-->

## Methods (with Parameters)

As we mentioned earlier, `methods:` promises are promises to take
on a whole other bundle of promises.

They may be parameterized.



\begin{codelisting}
\codecaption{250-210-Methods-0010-original\_form\_with\_any.cf}
```cfengine3, options: "linenos": false
bundle agent main {

  methods:
      "any"
         usebundle => say_hello;

}

bundle agent say_hello {

reports:  "hello!";

}
```
\end{codelisting}

<!---
Filename: 250-210-Methods-0010-original\_form\_with\_any.md
-->

Up until CFEngine 3.7, methods promises had the standard promise
form, complete with promiser, but the promiser didn't do anything:


```cfengine3
methods:

  "any"

    usebundle => my_bundle_name;
```

The author of CFEngine said to put "any" for the promiser for now,
and that the promiser was reserved for future development.



<!---
Filename: 250-210-Methods-0020-promiser\_as\_documentation.md
-->

The community started to use the promiser field of `methods` promises
to summarize/document what the called bundle was doing in human-readable
format, e.g.:

```cfengine3
methods:

  "Configure NTPD"

    usebundle => ntpd;
```




<!---
Filename: 250-210-Methods-0030-stuff.md
-->

As of CFEngine 3.7, the promiser can be used to provide the name
of the bundle to take on and the `usebundle` attribute can be
omitted, e.g.:

```cfengine3
methods:

  "ntpd";
```



<!---
Filename: 250-210-Methods-0040-parameterized.md
-->

However, you _do_ need the `usebundle` if you want to parameterize the methods call:

```cfengine3
  methods:                                                                                                                             
      "Remove Users"                                                                                                                   
        usebundle => remove_user("bob");           
```


\begin{codelisting}
\codecaption{250-210-Methods-0045-setup-users.sh}
```bash, options: "linenos": false
#!/bin/sh

set -x  # show us each command after expanding it,
        # so we can see what commands are being run

# Add a couple of users and a crontab to set up for the next example

sudo useradd alex
sudo useradd rob

# Create a crontab for user "alex"
EDITOR="/bin/echo @daily /bin/echo hello world > " sudo crontab -e -u alex

sudo crontab -l -u alex
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-210-Methods-0050-parameterized\_example--parameterized-list--inline-list.cf}
```cfengine3, options: "linenos": false
# Example of parameterizing a methods promise
# pass a list, not a scalar
bundle agent main
{
  vars:
      "userlist" slist => { "alex", "ben", "charlie", "diana", "rob" };

  methods:
      "Remove Users"
        usebundle => remove_users(@(userlist));
}

bundle agent remove_users(users_to_remove)
{
  reports:  
      "Checking $(users_to_remove)";

  commands:

    linux::
      "/bin/crontab -r -u $(users_to_remove)"
        if => fileexists("/var/spool/cron/$(users_to_remove)");
      "/usr/sbin/userdel -r $(users_to_remove)"
        if => userexists("$(users_to_remove)");
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-210-Methods-0050-parameterized\_example--parameterized-list.cf}
```cfengine3, options: "linenos": false
# Example of parameterizing a methods promise
# pass a list, not a scalar
bundle agent main
{
  vars:
      "userlist" slist => { "alex", "ben", "charlie", "diana", "rob" };

  methods:
      "Remove Users"
        usebundle => remove_users(@(userlist));
}

bundle agent remove_users(userlist)
{
  commands:
    linux::
      "/bin/crontab -r -u $(userlist)"
        if => fileexists("/var/spool/cron/$(userlist)");
      "/usr/sbin/userdel -r $(userlist)"
        if => userexists("$(userlist)");
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-210-Methods-0050-parameterized\_example.cf}
```cfengine3, options: "linenos": false
# Example of parameterizing a methods promise

bundle agent main
{
  vars:
      "userlist" slist => { "alex", "ben", "charlie", "diana", "rob" };

  methods:
      "Remove Users"
        usebundle => remove_user("$(userlist)");
}

bundle agent remove_user(user)
{
  commands:
      "/bin/crontab -r -u $(user)"
        if => fileexists("/var/spool/cron/$(user)");
      "/usr/sbin/userdel -r $(user)"
        if => userexists("$(user)");
}
```
\end{codelisting}
