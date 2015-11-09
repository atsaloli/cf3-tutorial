
<!---
Filename: 300-000-Part-Title-0000-Classes.md
-->

# Classifying (Grouping) Hosts

\coloredtext{red}{ 300-000-Part-Title-0000-Classes.md }


<!---
Filename: 300-010-Basic\_Examples\_Classes-0000-Classes-Chapter-Title.md
-->

## Hard classes

\coloredtext{red}{ 300-010-Basic\_Examples\_Classes-0000-Classes-Chapter-Title.md }


<!---
Filename: 300-010-Basic\_Examples\_Classes-0003-definition.md
-->

**Class**
: A group of things, animals, or people with similar features or qualities. ---Macmillan Dictionary

> Classes are the if ( test ) then of CFEngine language. Tests are built-in
> or user defined. Hosts that pass the test are members of the class.
> ---Neil Watson, CFEngine Consultant

\coloredtext{red}{ 300-010-Basic\_Examples\_Classes-0003-definition.md }


<!---
Filename: 300-010-Basic\_Examples\_Classes-0004-soft\_and\_hard.md
-->

### Hard and soft classes defined

There are two types of classes in CFEngine:

**Hard classes**
: Hard classes are inherent, or built-in. The first thing that `cf-agent` does when it starts is to classify its environment (e.g. OS type = linux, OS version = redhat 6.5, date = Sun Nov  8 17:09:57 PST 2015, CFEngine version = 3.7, hostname = alpha.example.com, domain = example.com, CPU architecture = 64 bit, etc.)  This data can be used to control promise execution (e.g. kick off backups at 2 AM on Sunday on Linux hosts only)

**Soft classes**
: Soft classes are user-defined through promises, and provide additional flexibility in classifying hosts (e.g. by application, or primary vs DR) and controlling promise execution (e.g. only evaluation promise2 if promise1 was repaired).

Let's start with examples of hard classes.

### Hard classes


\coloredtext{red}{ 300-010-Basic\_Examples\_Classes-0004-soft\_and\_hard.md }

\begin{codelisting}
\codecaption{300-010-Basic\_Examples\_Classes-0005-Classes\_Reports.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  reports:
    linux::
      "I love Linux";

  reports:
    WinXP::
      "I love Windows";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{300-010-Basic\_Examples\_Classes-0010-Using\_classes\_to\_determine\_role.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  reports:
    ipv4_205_186_156::
      "I am on our public net. I'll be a Web server.";

  reports:
    ipv4_10::
      "I am on our private net. I'll be a database server.";


}
```
\end{codelisting}
\begin{codelisting}
\codecaption{300-010-Basic\_Examples\_Classes-0050-Report\_OS\_Type.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  reports:

      WinXP:: "Hello world! I am running on a Windows system.";

      linux:: "Hello world! I am running on a Linux system.";

      redhat:: "Hello world! I am running on a redhat Linux system.";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{300-010-Basic\_Examples\_Classes-0060-Note\_on\_what\_happens\_to\_dashes\_in\_hostnames.cf}
```cfengine3, options: "linenos": true
# CFEngine automatically canonifies classes (converts any
# character that is not alphanum/underscore to underscore)
#
# To setup for this example, run "hostname my-hostname-has-dashes"

bundle agent main {

  reports:

      #my-hostname-has-dashes::
    my_hostname_has_dashes::

      "Hello world";

    banana::

      "My hostname is banana";

}

```
\end{codelisting}
<!---                 
Filename: 300-010-Basic\_Examples\_Classes-0070-examine\_hard\_classes.exr.md
-->

\begin{aside}
\label{aside:exercise_22}
\heading{Examine hard classes}


Run CFEngine in verbose mode:

```bash
cf-agent -v -f ./hello_world.cf | less
```

Examine what CFEngine discovered about your system and what classes it set.


\end{aside}
\coloredtext{red}{ 300-010-Basic\_Examples\_Classes-0070-examine\_hard\_classes.exr.md }
<!---                 
Filename: 300-010-Basic\_Examples\_Classes-0080-using\_hard\_classes.exr.md
-->

\begin{aside}
\label{aside:exercise_23}
\heading{Using classes}


Print a report if you running in a CentOS 6 system.


\end{aside}
\coloredtext{red}{ 300-010-Basic\_Examples\_Classes-0080-using\_hard\_classes.exr.md }

<!---
Filename: 300-015-Basic\_Examples\_Classes\_2-0000-Chapter-Title.md
-->

## Class Expressions

\coloredtext{red}{ 300-015-Basic\_Examples\_Classes\_2-0000-Chapter-Title.md }


<!---
Filename: 300-015-Basic\_Examples\_Classes\_2-0080-Class\_expression\_operators.md
-->

Class expressions are logical expressions that evaluate to true (this promise applies here) or false (the promise does not apply here, skip it).

Class expressions are composed of classes and logical operators.

### Logical operators

**Operator**
: In programming, a symbol used to perform an arithmetic or logical operation. 

--- http://encyclopedia2.thefreedictionary.com/operator


Logical operators (in order of precedence of operation)

| ( ) |  Groupers |
| ! | NOT |
| & or . | AND |
| \| or \|\| | OR |

### Truth tables
If necessary, review [truth tables](https://en.wikipedia.org/wiki/Truth_table#Logical_conjunction_.28AND.29) for logical operations AND, OR, and NOT

### Examples of class expressions

\coloredtext{red}{ 300-015-Basic\_Examples\_Classes\_2-0080-Class\_expression\_operators.md }

\begin{codelisting}
\codecaption{300-015-Basic\_Examples\_Classes\_2-0090-Class\_expression\_operators.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  reports:

      linux:: "I am running on a linux system.";

      WinXP:: "I am running on a Windows system.";

      !WinXP:: "Thank goodness.";

      WinXP|linux::  "Am I laughing or crying?";

      WinXP&linux::  "We should never see this report.";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{300-015-Basic\_Examples\_Classes\_2-0100-Report\_day\_of\_the\_week.cf}
```cfengine3, options: "linenos": true
# The following bundle does not use class expressions.
# The next one will.

bundle agent main {

  reports:

    Monday::
      "Hello world! I love Mondays!";

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
```cfengine3, options: "linenos": true
bundle agent main {

  reports:

    Monday|Tuesday|Wednesday|Thursday|Friday::
      "Yay!!! I get to work today!";

    Saturday|Sunday::
      "Yay!!! I get to rest today.";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{300-015-Basic\_Examples\_Classes\_2-0120-OS\_and\_time\_expression.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  reports:

      linux.Hr08:: "Linux system AND we are in the 8th hour.";
      linux.Hr11:: "Linux system AND we are in the 11th hour.";
      linux.Hr12:: "Linux system AND we are in the 12th hour.";

      linux.Hr13:: "Linux system AND we are in the 13th hour.";
      linux.Hr16:: "Linux system AND we are in the 16th hour.";


      linux&Hr22:: "Linux system AND we are in the 22nd hour.";

      linux&Hr20:: "Linux system AND we are in the 20th hour.";
}

```
\end{codelisting}
\begin{codelisting}
\codecaption{300-015-Basic\_Examples\_Classes\_2-0130-Class\_expression\_OS\_and\_time.cf}
```cfengine3, options: "linenos": true
bundle agent main {

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

\coloredtext{red}{ 300-015-Basic\_Examples\_Classes\_2-0133-soft\_classes.md }

\begin{codelisting}
\codecaption{300-015-Basic\_Examples\_Classes\_2-0134-soft\_classes\_simple.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  classes:
      "weekend"
        expression => "Saturday|Sunday";

  reports:
    weekend::
      "Yay! I get to rest today.";

}

# When you run this in verbose mode, you should see when CFEngine sets
# the soft class:
#
# verbose: Using bundlesequence =>  {'main'}
# verbose: B: *****************************************************************
# verbose: B: BEGIN bundle main
# verbose: B: *****************************************************************
# verbose: C: .........................................................
# verbose: C: BEGIN classes / conditions (pass 1)
# verbose: C: .........................................................
# verbose: C:     +  Private class: weekend 
# verbose: P: .........................................................
# verbose: P: BEGIN promise 'p
```
\end{codelisting}
\begin{codelisting}
\codecaption{300-030-Basic\_Examples\_Classes\_2-0140-Detect\_VMs.cf}
```cfengine3, options: "linenos": true
# You can set a soft class based on the outcome
# of a function that returns true/false, such as
# regline() which checks if there is a line in a
# file matching a regular expression.

bundle agent main {

  classes:
      "i_am_virtual"
        handle => "reality_check",
        comment => "Check if we are running inside a VM",
        expression => regline(".*VMware.*",
                              "/proc/scsi/scsi");

# This is what we wouls see in the shell:
#
# $ grep -i vmware /proc/scsi/scsi
# Vendor: VMware,  Model: VMware Virtual S Rev: 1.0 
# Vendor: NECVMWar Model: VMware SATA CD01 Rev: 1.00
# $

  reports:
    i_am_virtual::
      "Running inside a VM";
}
```
\end{codelisting}

<!---
Filename: 300-040-Classes\_4-0000-Chapter-Title.md
-->

### Creating soft classes depending on promise outcome

Some promise attributes can create Classes depending on the outcome of the promise.

\coloredtext{red}{ 300-040-Classes\_4-0000-Chapter-Title.md }

\begin{codelisting}
\codecaption{300-040-Classes\_4-0020-Ensuring\_CUPSd\_is\_running.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  processes:

      "cupsd"

        restart_class => "cups_needs_to_be_started",
        comment => "We want print services";


  commands:

    cups_needs_to_be_started::

      "/etc/init.d/cups"

        args => "start";


}
```
\end{codelisting}
\begin{codelisting}
\codecaption{300-040-Classes\_4-0030-Ensuring\_httpd\_is\_running.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  processes:
      "httpd"
        restart_class => "start_httpd";

  commands:
    start_httpd::
      "/etc/init.d/httpd start";

}
```
\end{codelisting}
