
<!---
Filename: 310-000-Part-Title-0000-Language\_Notes.md
-->

# Notes on Syntax and Internals



<!---
Filename: 310-010-Notes\_on\_Syntax-0000-Chapter-Title.md
-->

## Basic Structure

A **promise** is a statement of intention.

A **bundle** is a group of one or more promises.


\begin{codelisting}
\codecaption{310-010-Notes\_on\_Syntax-0350-Two\_promises\_in\_one\_bundle.cf}
```cfengine3, options: "linenos": false
# Example of multiple promises in one bundle

bundle agent main
{
  files:
      "/tmp/hello"
        create  => "true";

  files:
      "/tmp/world"
        create  => "true";
}
```
\end{codelisting}

<!---
Filename: 310-010-Notes\_on\_Syntax-0359-Two\_bundles\_in\_one\_file.md
-->

## Bundles and Files

You can have multiple bundles in one file. Or you can have one bundle
per file. Whatever makes the most sense for organizing your policy set.



\begin{codelisting}
\codecaption{310-010-Notes\_on\_Syntax-0360-Two\_bundles\_in\_one\_file.cf}
```cfengine3, options: "linenos": false
# Example of two bundles in one file
#
# $(this.bundle) is a special variable that contains the name of the
# current bundle.
#
# A `methods:` promise is a promise to take on a whole another bundle of
# promises.

bundle agent main
{
  methods:
      "bundle_2";

  reports:
      "I am in the $(this.bundle) bundle";
}

bundle agent bundle_2
{
  reports:
      "I am in the $(this.bundle) bundle";
}
```
\end{codelisting}

<!---
Filename: 310-010-Notes\_on\_Syntax-0369-Whitespace\_and\_indentation\_do\_not\_matter.md
-->

## Whitespace

Whitespace and indentation do not matter.


\begin{codelisting}
\codecaption{310-010-Notes\_on\_Syntax-0370-Whitespace\_and\_indentation\_do\_not\_matter.cf}
```cfengine3, options: "linenos": false
# Whitespace/indentation does not matter, these bundles will both work

bundle agent with_whitespace
{
  files:
      "/etc/nologin"
        create => "true";
}

bundle agent no_whitespace { files: "/etc/nologin" create => "true"; }
```
\end{codelisting}

<!---
Filename: 310-010-Notes\_on\_Syntax-0375-style\_guide.md
-->

See [CFEngine Style
Guide](https://docs.cfengine.com/latest/guide-writing-and-serving-policy-policy-style.html)




<!---
Filename: 310-010-Notes\_on\_Syntax-0381-syntax\_pattern\_intro.BOOKONLY.md
-->

## Introduction to Syntax Pattern

The CFEngine 2 language grew organically, as many features were added.

It developed some internal inconsistency as a result.

CFEngine 3 greatly streamlines the CFEngine language, and makes it more **regular**.

The CFEngine 3 language is flexible and powerful; and also very regular.

The basic pattern is: CFEngine reserved word on the left, user-defined choice on the right.

The following illustrates the pattern of the CFEngine 3 language.

![Syntax Pattern 1](images/figures/syntax_pattern_intro.pdf)



<!---
Filename: 310-010-Notes\_on\_syntax-0353-reusing\_promise\_type.md
-->

CFEngine allows you to write shorter code without loss of meaning:
don't specify the promise type, and CFEngine will re-use the promise
type of the preceding promise.


\begin{codelisting}
\codecaption{310-010-Notes\_on\_syntax-0355-Two\_promises\_in\_one\_bundle\_Condensed.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  files:

      "/tmp/hello"
        create  => "true";

      "/tmp/world"
        create  => "true";
}
```
\end{codelisting}

<!---
Filename: 310-010-Notes\_on\_syntax-0356-comments.md
-->

## Comments

Comments can be part of the CFEngine promise code (inline), or
hash-comments, which are thrown away by the parser.


\begin{codelisting}
\codecaption{310-010-Notes\_on\_syntax-0358-comments.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  files:
      "/tmp/hello"
        create  => "true",
        comment => "inline-comments show up in verbose mode";
      # hash-comments are thrown away by parser
}
```
\end{codelisting}

<!---
Filename: 310-030-Notes\_on\_Running-0010-three\_passes.md
-->

CFEngine will make up to three passes through each bundle to speed
convergence to desired state.

Sometimes a promise cannot be repaired because there is a broken
dependency.

CFEngine will make multiple passes in auditing/repairing a system. After
dependencies are repaired, repairs of dependent promises can now succeed.

Run `cf-agent` with the -v switch (verbose) and look for "pass 1", "pass
2", and "pass 3" to observe the three passes.


\begin{codelisting}
\codecaption{310-030-Notes\_on\_Running-0020-three\_passes.cf}
```cfengine3, options: "linenos": false
# Demonstrate three passes through a bundle by using verbose mode

bundle agent main
{
  files:
      "/tmp/example"
        handle => "create_a_file",
        create  => "true";
}
```
\end{codelisting}
<!---                 
Filename: 310-030-Notes\_on\_Running-0030-three\_passes.exr.md
-->

\begin{aside}
\label{aside:exercise_20}
\heading{Observe three passes}


Run one of your previous exercise files in verbose mode and observe what
happens in which pass, and how the passes are labeled.


\end{aside}

<!---
Filename: 310-030-Notes\_on\_running-0000-Chapter-Title.md
-->

## Multiple Passes and Convergence



<!---
Filename: 310-040-Ordering-0000-Chapter-Title.md
-->

## Ordering



<!---
Filename: 310-040-Ordering-0010-partial\_normal\_ordering\_list.md
-->

There is an order to promise evaluation.

Promises are evaluated in order by promise type.

For example, for the promise types we've covered,
the order is:

- vars
- files
- methods
- processes
- commands
- reports

Why is this?



<!---
Filename: 310-040-Ordering-0020-why\_normal\_ordering.md
-->

This order is _very_ intentional and is _not_ configurable.




<!---
Filename: 310-040-Ordering-0021-variables.md
-->

Variables are evaluated first as they may be used in other promises.




<!---
Filename: 310-040-Ordering-0023-files.md
-->

Files are handled before Processes as one may want to configure a service
and then launch the daemon.




<!---
Filename: 310-040-Ordering-0024-processes.md
-->

Processes come before Commands as one may want to run a command to start
or stop a service depending on whether the process is running.




<!---
Filename: 310-040-Ordering-0025-reports.md
-->

Reports come last so that the reports are not immediately made out of
date (in other words, reports are last so that CFEngine doesn't report
something and then changes it).




<!---
Filename: 310-040-Ordering-0026-link.md
-->

This is called Normal Ordering.

Reference: [Normal
Ordering](https://docs.cfengine.com/latest/reference-language-concepts-normal-ordering.html)



<!---
Filename: 310-040-Ordering-0030-recap.md
-->

#### Recap

To facilitate convergence, CFEngine evaluates and repairs
promises according to CFEngine "normal ordering".

Promises of different types are evaluated according to "normal ordering".

Promises of the same type are evaluated in the order they appear in the file.


\begin{codelisting}
\codecaption{310-040-Ordering-0040-ordering\_within\_a\_single\_promise\_type\_is\_linear.cf}
```cfengine3, options: "linenos": false
# Promises of the same type are evaluated in the order they appear in
# the file.

bundle agent main
{
  reports:
      "Two";
      "Three";
      "One";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{310-040-Ordering-0050-simple\_ordering\_example.cf}
```cfengine3, options: "linenos": false
# Promises of different types are evaluated according to "normal
# ordering".
#
# What are we going to see? What will be the order of the output statements?

bundle agent main
{
  reports:
      "Hello world!";

  commands:
      "/bin/echo Good morning!";

  reports:
      "I love tomatoes";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{310-040-Ordering-0060-fileexists.cf}
```cfengine3, options: "linenos": false
# This example introduces the fileexists() function.
#
# We will use fileexists() in an upcoming example

bundle agent main
{
  classes:
      "motd_present"
        expression => fileexists("/etc/motd");

      "motd_absent"
        not => fileexists("/etc/motd");

  reports:
      motd_present::  "OK - found motd: /etc/motd";
      motd_absent::   "FAIL - motd not found: /etc/motd";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{310-040-Ordering-0070-rm\_tmp\_newfile.sh}
```bash, options: "linenos": false
#!/bin/sh

# Set up for the next example by ensuring we do not have /tmp/newfile

sudo rm -f /tmp/newfile
```
\end{codelisting}
\begin{codelisting}
\codecaption{310-040-Ordering-0080-normal\_ordering.cf}
```cfengine3, options: "linenos": false
# Run "/bin/rm /tmp/newfile" to setup for this example

bundle agent main
{
  classes:
      "file_exists"
        expression => fileexists("/tmp/newfile");

      "file_absent"
        not => fileexists("/tmp/newfile");

  files:
      "/tmp/newfile"
        create => "true";

  reports:
    file_exists::
      "file /tmp/newfile exists";

    file_absent::
      "file /tmp/newfile does not exist";
}

# Why does CFEngine print both reports when /tmp/newfile is absent?
```
\end{codelisting}
<!---                 
Filename: 310-040-Ordering-0090-Classes\_and\_Reports\_Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_21}
\heading{Run the previous example in verbose mode so you can see}

what happens during which pass.


\end{aside}
<!---                 
Filename: 310-040-Ordering-0100-methods\_ordering.exr.md
-->

\begin{aside}
\label{aside:exercise_22}
\heading{Ordering of promises}


1. Create two bundles and make each bundle report its name.

2. Additionally, have bundle #1 call bundle #2 (via a `methods:`
   promise).

What is the order of the bundle names in the reports and why?


\end{aside}
