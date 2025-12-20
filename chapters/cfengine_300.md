
<!---
Filename: 300-000-Part-Title-0000-Classes.md
-->

# Classifying (Grouping) Hosts



<!---
Filename: 300-010-Basic\_Examples\_Classes-0000-Chapter-Title.md
-->

## Hard classes



<!---
Filename: 300-010-Basic\_Examples\_Classes-0010-definition.md
-->

**Class**
: A group of things, animals, or people with similar features or qualities. ---Macmillan Dictionary

> Classes are the if ( test ) then of CFEngine language. Tests are built-in
> or user defined. Hosts that pass the test are members of the class.
> ---Neil Watson, CFEngine Consultant



<!---
Filename: 300-010-Basic\_Examples\_Classes-0020-soft\_and\_hard.md
-->

### Hard and soft classes defined

There are two types of classes in CFEngine:

**Hard classes**
: Hard classes are inherent, or built-in. The first thing that `cf-agent`
does when it starts is to classify its environment (e.g.  OS type = linux,
OS version = redhat 6.5, date = Sun Nov  8 17:09:57 PST 2015, CFEngine
version = 3.7, hostname = alpha.example.com, domain = example.com, CPU
architecture = 64 bit, etc.)  This data can be used to control promise
execution (e.g. kick off backups at 2 AM on Sunday on Linux hosts)

**Soft classes**
: Soft classes are user-defined through promises, and provide additional
flexibility in classifying hosts (e.g. by application, or primary vs
DR) and controlling promise execution (e.g. only evaluate promise2 if
promise1 was repaired).




<!---
Filename: 300-010-Basic\_Examples\_Classes-0025-note\_on\_syntax\_identifiers.md
-->

#### Note on Syntax: CFEngine Identifiers

Note on syntax: CFEngine identifiers (class names, variable names, bundle
names, etc.) may only contain alphanumeric and underscore characters (a-zA-Z0-9_).



<!---
Filename: 300-010-Basic\_Examples\_Classes-0028-hard\_classes\_intro.md
-->

### Hard classes

Let's see some examples of hard classes.


\begin{codelisting}
\codecaption{300-010-Basic\_Examples\_Classes-0030-Classes\_Reports.cf}
```cfengine3, options: "linenos": false
# Operating System

bundle agent main
{
  commands:
    linux::
      "/bin/date";

    windows::
      "C:\Windows\System32\cmd.exe /c date /t";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{300-010-Basic\_Examples\_Classes-0040-Using\_classes\_to\_determine\_role.cf}
```cfengine3, options: "linenos": false
# IPv4 network blocks

bundle agent main
{
  reports:
    ipv4_205_186_156::
      "I am on our public net. I am a Web server.";

    ipv4_10::
      "I am on our private net. I am a database server.";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{300-010-Basic\_Examples\_Classes-0050-Report\_OS\_Type.cf}
```cfengine3, options: "linenos": false
# OS flavor (e.g. Windows XP or Red Hat)

bundle agent main
{
  reports:
    WinXP:: "Hello world! I am running on a Windows system.";
    linux:: "Hello world! I am running on a Linux system.";
    redhat:: "Hello world! I am running on a redhat Linux system.";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{300-010-Basic\_Examples\_Classes-0060-Note\_on\_what\_happens\_to\_dashes\_in\_hostnames.cf}
```cfengine3, options: "linenos": false
# CFEngine automatically canonifies classes (converts any
# character that is not alphanum/underscore to underscore)
#
# To setup for this example, run "hostname my-hostname-has-dashes"

bundle agent main
{
  reports:
    any::
      "hello world";
    my-hostname-has-dashes::
      "One";
    my_hostname_has_dashes::
      "Two";

}

```
\end{codelisting}
<!---                 
Filename: 300-010-Basic\_Examples\_Classes-0070-examine\_hard\_classes.exr.md
-->

\begin{aside}
\label{aside:exercise_18}
\heading{Examine hard classes}


Run CFEngine in verbose mode:

```bash
cf-agent -v -f ./hello_world.cf | less
```

Examine what CFEngine discovered about your system and what classes it set.

Give an example of a class that CFEngine has set.


\end{aside}
<!---                 
Filename: 300-010-Basic\_Examples\_Classes-0080-using\_hard\_classes.exr.md
-->

\begin{aside}
\label{aside:exercise_19}
\heading{Using classes}


Print a report if you're running on a CentOS 7 system.


\end{aside}

<!---
Filename: 300-015-Basic\_Examples\_Classes\_2-0000-Chapter-Title.md
-->

## Class Expressions



<!---
Filename: 300-015-Basic\_Examples\_Classes\_2-0070-class\_xpr\_intro.md
-->

**Class expressions**
: Class expressions are logical expressions that evaluate to true (this
promise applies here) or false (the promise does not apply, skip it).

Class expressions are composed of classes and logical operators.




<!---
Filename: 300-015-Basic\_Examples\_Classes\_2-0080-Class\_expression\_operators.BOOKONLY.md
-->

### Logical operators

**Operator**
: In programming, a symbol used to perform an arithmetic or logical operation. 

--- http://encyclopedia2.thefreedictionary.com/operator

Logical operators (in order of precedence of operation)

| ( ) |  Groupers |
| ! | NOT |
| & or . | AND |
| \| or \|\| | OR |




<!---
Filename: 300-015-Basic\_Examples\_Classes\_2-0082-truth\_tables.md
-->

### Truth tables

If necessary, review [truth tables](https://en.wikipedia.org/wiki/Truth_table#Logical_conjunction_.28AND.29) for logical operations AND, OR, and NOT.




<!---
Filename: 300-015-Basic\_Examples\_Classes\_2-0084-examples\_of\_class\_expressions.md
-->

### Examples of class expressions



\begin{codelisting}
\codecaption{300-015-Basic\_Examples\_Classes\_2-0090-Class\_expression\_operators.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  reports:
    !WinXP:: "This isn't Windows XP";
    windows|linux::  "Am I laughing or crying?";
    windows&linux::  "We should never see this report.";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{300-015-Basic\_Examples\_Classes\_2-0100-Report\_day\_of\_the\_week.cf}
```cfengine3, options: "linenos": false
# This bundle does not use class expressions.

bundle agent main
{
  reports:

    Monday::    "Hello world! I love Mondays!";
    Tuesday::   "Hello world! I love Tuesdays!";
    Wednesday:: "Hello world! I love Wednesdays!";
    Thursday::  "Hello world! I love Thursdays!";
    Friday::    "Hello world! I love Fridays!";

    Saturday::  "Hello world! I love weekends!";
    Sunday::    "Hello world! I love weekends!";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{300-015-Basic\_Examples\_Classes\_2-0110-Condensed\_report\_day\_of\_week.cf}
```cfengine3, options: "linenos": false
# This bundle uses class expressions.

bundle agent main
{
  reports:
    Monday|Tuesday|Wednesday|Thursday|Friday::
      "I get to work today";

    Saturday|Sunday::
      "I get to rest today.";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{300-015-Basic\_Examples\_Classes\_2-0120-OS\_and\_time\_expression.cf}
```cfengine3, options: "linenos": false
# Another example of a class expression

bundle agent main
{
  reports:
      linux&Hr22::
        "Linux system AND we are in the 22nd hour.";
}

```
\end{codelisting}
\begin{codelisting}
\codecaption{300-015-Basic\_Examples\_Classes\_2-0130-Class\_expression\_OS\_and\_time.cf}
```cfengine3, options: "linenos": false
# Example of using ( ) for grouping

bundle agent main
{
  reports:
    (redhat&Monday)|(windows&Wednesday)::
      "This report will show on Redhat servers on Mondays;
       or on Windows servers on Wednesdays";
}
```
\end{codelisting}

<!---
Filename: 300-015-Basic\_Examples\_Classes\_2-0133-soft\_classes.md
-->

## Soft classes

You can define a soft class using a `classes:` promise.


\begin{codelisting}
\codecaption{300-015-Basic\_Examples\_Classes\_2-0134-soft\_classes\_simple.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  classes:
      "weekend"
        expression => "Saturday|Sunday";
      "weekday"
        expression => "Monday|Tuesday|Wednesday|Thursday|Friday";

  reports:
    weekend::
      "Yay! I get to rest today.";
    weekday::
      "Yay! I get to work today.";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{300-015-Basic\_Examples\_Classes\_2-0140-negative\_knowledge.cf}
```cfengine3, options: "linenos": false
# Example of "negative knowledge" -- not recommended!
# Better to be certain (rely on the presence of something,
# not its absence).

bundle agent main
{
  classes:
      "weekend"
        expression => "Saturday|Sunday";
      "weekday"
        not => "weekend";

  reports:
    weekend::
      "Yay! I get to rest today.";
    weekday::
      "Yay! I get to work today.";
}

# Knowing that something is not the case is not the same as not knowing
# whether something is the case. That a class is not set could mean
# either.
#
# Reference:  <https://docs.cfengine.com/docs/3.17/reference-language-concepts-classes.html#negative-knowledge>
```
\end{codelisting}
\begin{codelisting}
\codecaption{300-030-Basic\_Examples\_Classes\_2-0140-Detect\_VMs.cf}
```cfengine3, options: "linenos": false
# You can set a soft class based on the outcome
# of a function that returns true/false, such as
# `regline()` which checks if there is a line in a
# file matching a regular expression.

bundle agent main
{
  classes:
      "i_am_virtual"
        comment => "Check if we are running inside a VM",
        expression => regline(".*(VMware|VBOX|QEMU).*",
                              "/proc/scsi/scsi");

# E.g., on a VMware guest, we have:
#
# $ grep -i vmware /proc/scsi/scsi
# Vendor: VMware,  Model: VMware Virtual S Rev: 1.0
# Vendor: NECVMWar Model: VMware SATA CD01 Rev: 1.00
# $

  reports:
    i_am_virtual::
      "Running inside a VM";
}

# See also the "virt-what" utility
```
\end{codelisting}

<!---
Filename: 300-040-Classes\_4-0000-Chapter-Title.md
-->

### Creating soft classes depending on promise outcome

Some promise attributes can create Classes depending on the outcome of
the promise.


\begin{codelisting}
\codecaption{300-040-Classes\_4-0020-Ensuring\_CUPSd\_is\_running.cf}
```cfengine3, options: "linenos": false
# restart_class will set the class if the process is ABSENT
# <https://docs.cfengine.com/latest/reference-promise-types-processes.html#restart_class>

bundle agent main
{
  processes:
    print_servers::
      "cupsd"
        restart_class => "cups_needs_to_be_started",
        comment => "We want print services";

  commands:
    cups_needs_to_be_started::
      "/sbin/service cups start";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{300-040-Classes\_4-0030-Ensuring\_httpd\_is\_running.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  processes:
      "httpd"
        restart_class => "start_httpd";

  commands:
    start_httpd::
      "/sbin/service httpd start";
}
```
\end{codelisting}
