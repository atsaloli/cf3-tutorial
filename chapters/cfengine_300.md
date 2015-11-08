
<!---
Filename: 300-000-Part-Title-0000-Classes.md
-->

# Classifying (Grouping) Hosts

\coloredtext{red}{ 300-000-Part-Title-0000-Classes.md }


<!---
Filename: 300-010-Basic\_Examples\_Classes-0000-Classes-Chapter-Title.md
-->

## Classes

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
# CFEngine automatically canonifies hard classes (converts any
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
\heading{}

Examine Hard Classes

Run CFEngine in verbose mode:

```bash
cf-agent -v -f ./hello_world.cf | less
```

Examine what CFEngine discovered about your system and what hard classes it set.


\end{aside}
\coloredtext{red}{ 300-010-Basic\_Examples\_Classes-0070-examine\_hard\_classes.exr.md }
<!---
Filename: 300-010-Basic\_Examples\_Classes-0080-using\_hard\_classes.exr.md
-->
\begin{aside}
\label{aside:exercise_23}
\heading{}

Using hard classes

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

Class operators are used in logical expressions


**Operator**
: In programming, a symbol used to perform an arithmetic or logical operation. 
--- http://encyclopedia2.thefreedictionary.com/operator



### Operators

Logical operators (in order of precedence of operation)

| ( ) |  Groupers |
| ! | NOT |
| & or . | AND |
| \| or \|\| | OR |

### Truth Tables
If necessary, review [truth tables](https://en.wikipedia.org/wiki/Truth_table#Logical_conjunction_.28AND.29) for logical operations AND, OR, and NOT

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
\begin{codelisting}
\codecaption{300-030-Basic\_Examples\_Classes\_2-0140-Detect\_VMs.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  classes:
      "i_am_virtual"
        handle => "reality_check",
        comment => "Check if we are running inside a VM",
        expression => regline("(?i).*vmware.*|(?i).*vbox.*|(?i).*qemu.*",
                              "/proc/scsi/scsi");
      # (?i) is the "case-insensitive" switch
      # The shell equivalent would be:
      # /bin/egrep -i 'vmware|vbox|qemu' /proc/scsi/scsi

  reports:
    i_am_virtual::
      "Running inside a VM";
}
```
\end{codelisting}

<!---
Filename: 300-030-Classes-0000-Chapter-Title.md
-->

## Promises about Classes

\coloredtext{red}{ 300-030-Classes-0000-Chapter-Title.md }


<!---
Filename: 300-040-Classes\_4-0000-Chapter-Title.md
-->

## Other ways to create Classes

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
