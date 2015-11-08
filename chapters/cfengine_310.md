
<!---
Filename: 310-000-Part-Title-0000-Language\_Notes.md
-->

# Notes on Syntax and Internals

\coloredtext{red}{ 310-000-Part-Title-0000-Language\_Notes.md }


<!---
Filename: 310-010-Notes\_on\_Syntax-0000-Chapter-Title.md
-->

## Basic Structure

A bundle is a group of one or more promises.  

\coloredtext{red}{ 310-010-Notes\_on\_Syntax-0000-Chapter-Title.md }

\begin{codelisting}
\codecaption{310-010-Notes\_on\_Syntax-0350-Two\_promises\_in\_one\_bundle.cf}
```cfengine3, options: "linenos": true
bundle agent main {

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
Filename: 310-010-Notes\_on\_syntax-0353-reusing\_promise\_type.md
-->

CFEngine allows you to write shorter code without loss of meaning:
don't specify the promise type, and CFEngine will re-use the promise
type of the preceding promise.

\coloredtext{red}{ 310-010-Notes\_on\_syntax-0353-reusing\_promise\_type.md }

\begin{codelisting}
\codecaption{310-010-Notes\_on\_syntax-0355-Two\_promises\_in\_one\_bundle\_Condensed.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/tmp/hello"
        create  => "true";

      "/tmp/world"
        create  => "true";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{310-010-Notes\_on\_syntax-0358-comments.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/tmp/hello"
        create  => "true",
        comment => "inline-comments show up in verbose mode";
      # hash-comments are thrown away by parser.
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{310-010-Notes\_on\_Syntax-0360-Two\_bundles\_in\_one\_file.cf}
```cfengine3, options: "linenos": true
bundle agent your_bundle_name {

      files: "/tmp/file1" create  => "true";

}

bundle agent example {

      files: "/tmp/file2" create  => "true";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{310-010-Notes\_on\_Syntax-0370-Whitespace\_and\_indentation\_do\_not\_matter.cf}
```cfengine3, options: "linenos": true
# Whitespace/indentation does not matter, these bundles will both work

bundle agent with_whitespace {

  files:

      "/etc/nologin"

        create => "true";
}


bundle agent no_whitespace { files: "/etc/nologin" create => "true"; }
```
\end{codelisting}

<!---
Filename: 310-030-Notes\_on\_running-0000-Chapter-Title.md
-->

## Multiple passes and Convergence

\coloredtext{red}{ 310-030-Notes\_on\_running-0000-Chapter-Title.md }


<!---
Filename: 310-030-Notes\_on\_Running-0010-three\_passes.md
-->

CFEngine will make up to three passes through each bundle to speed convergence to desired state.

Sometimes a promise cannot be repaired because there is a broken dependency.

CFEngine will make multiple passes in auditing/repairing a system. After dependencies are repaired, repairs of dependent promises can now succeed.

Run cf-agent with the -v switch (verbose) and look for "pass 1", "pass 2", and "pass 3" to observe the three passes.

\coloredtext{red}{ 310-030-Notes\_on\_Running-0010-three\_passes.md }

\begin{codelisting}
\codecaption{310-030-Notes\_on\_Running-0020-three\_passes.cf}
```cfengine3, options: "linenos": true
# demonstrate three passes through a bundle by using verbose mode

bundle agent main {

  files:

      "/etc/nologin"

        handle => "touch_etc_nologin",
        comment => "Quiesce the system for maintenance",
        create  => "true";

}
```
\end{codelisting}
<!---
Filename: 310-030-Notes\_on\_Running-0030-three\_passes.exr.md
-->
\begin{aside}
\label{aside:exercise_24}
\heading{}

Observe three passes

Run one of your previous exercise files in verbose mode and observe what happens in which pass, and how the passes are labeled.


\end{aside}
\coloredtext{red}{ 310-030-Notes\_on\_Running-0030-three\_passes.exr.md }

<!---
Filename: 310-040-Ordering-0000-Chapter-Title.md
-->

## Ordering

\coloredtext{red}{ 310-040-Ordering-0000-Chapter-Title.md }


<!---
Filename: 310-040-Ordering-0004-intro.md
-->

To facilitate convergence, CFEngine evaluates and repairs promises according to CFEngine "normal ordering" (see https://docs.cfengine.com/docs/master/guide-language-concepts-normal-ordering.html)

Promises of the same type are evaluated in the order they appear in the file.

Promises of different types are evaluated according to "normal ordering".

\coloredtext{red}{ 310-040-Ordering-0004-intro.md }

\begin{codelisting}
\codecaption{310-040-Ordering-0005-ordering\_within\_a\_single\_promise\_type\_is\_linear.cf}
```cfengine3, options: "linenos": true
### demonstrate ordering within a single promise type

bundle agent main {

  reports:
      "Two";
      "Three";

  reports:
      "One";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{310-040-Ordering-0010-simple\_ordering\_example.cf}
```cfengine3, options: "linenos": true
bundle agent main
{
  reports:

      "Hello world!";

  commands:

      "/bin/echo Good morning!";

#  reports:
#      " I love tomatoes";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{310-040-Ordering-0015-fileexists.cf}
```cfengine3, options: "linenos": true
# This example introduces the fileexists() function
#
# We will use fileexists() in a later, more complicated
# demonstration of normal ordering

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
\codecaption{310-040-Ordering-0020-normal\_ordering.cf}
```cfengine3, options: "linenos": true
bundle agent main {

# run /bin/rm /tmp/newfile to setup for this example

  classes:
      "file_exists"
        expression => fileexists("/tmp/newfile");
      "file_absent"
        not => fileexists("/tmp/newfile");

  files:
      "/tmp/newfile"
        handle => "create_a_file",
        comment => "Give CFEngine something to do
                          to change system state.",
        create => "true";

  reports:
    file_exists::
      "file /tmp/newfile exists";

    file_absent::
      "file /tmp/newfile does not exist";
}
```
\end{codelisting}
<!---
Filename: 310-040-Ordering-0050-Classes\_and\_Reports\_Exercise.exr.md
-->
\begin{aside}
\label{aside:exercise_25}
\heading{}

Run the previous example in verbose mode so you can see
what happens during which pass.


\end{aside}
\coloredtext{red}{ 310-040-Ordering-0050-Classes\_and\_Reports\_Exercise.exr.md }

<!---
Filename: 310-050-Knowledge\_Management-0000-Chapter-Title.md
-->

## Knowledge Management

\coloredtext{red}{ 310-050-Knowledge\_Management-0000-Chapter-Title.md }


<!---
Filename: 310-050-Knowledge\_Management-0240-is\_one\_of\_the\_key\_challenges\_of\_scale.md
-->

TIP: Knowledge Management is one of the key challenges of scale.

\coloredtext{red}{ 310-050-Knowledge\_Management-0240-is\_one\_of\_the\_key\_challenges\_of\_scale.md }

\begin{codelisting}
\codecaption{310-050-Knowledge\_Management-0250-handle.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/tmp/testfile"

        handle => "create_testfile", # a name for this promise.

      # can be used with depends_on
      # attribute in another promise
      # to document dependency
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{310-050-Knowledge\_Management-0251-duplicate-handle.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/tmp/testfile"

        handle => "create_testfile", # a name for this promise.

      # can be used with depends_on
      # attribute in another promise
      # to document dependency

        create  => "true";

  reports:
    # demonstrate handle conflict
     "hello world"
       handle => "create_testfile";
       
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{310-050-Knowledge\_Management-0260-depends\_on.cf}
```cfengine3, options: "linenos": true
# depends_on controls policy flow.

bundle agent main
{

  reports:

      "System Check"
        handle => "systems_check";

      "Launch!!"
        depends_on => { "fuel_check", "systems_check" },
        handle => "ignition",
        comment => "Demonstrate flow control with depends_on";

      "Fueling..." 
        handle => "fuel_check";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{310-050-Knowledge\_Management-0265-promisee.cf}
```cfengine3, options: "linenos": true
# Demonstrate how depends_on controls policy flow.

bundle agent main
{

  reports:

      "Fueling" -> { ignition }
        handle => "fuel_check";




# long complex policy here











      "Launch!!"
        depends_on => { "fuel_check" },
        handle => "ignition",
        comment => "Demonstrate flow control with depends_on";


      # students should be encouraged to think
      # declaratively
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{310-050-Knowledge\_Management-0270-comment.cf}
```cfengine3, options: "linenos": true
# run this in verbose mode and notice the comment

bundle agent main {

  files:

      "/tmp/testfile"


        handle => "mk_file",
        comment => "Create a vital file, needed for XYZ.",
        create  => "true";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{310-050-Knowledge\_Management-0280-comment\_with\_file\_name\_and\_line\_number.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:
      "name"
        string => "George";

  files:

      "/tmp/testfile"


        handle => "demo_special_variables_in_comment",
        comment => "XYZ needs /tmp/testfile so make it.
Line $(this.promise_linenumber) in $(this.promise_filename)
",
      # this comment will show up in verbose or debug modes

        create  => "true";

  reports:
    DEBUG|DEBUG_example::
      "DEBUG bundle = $(this.bundle)";
      "name = '$(name)'";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{310-050-Knowledge\_Management-0290-promisee.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/etc/httpd/conf/httpd.conf" -> "Web Services team"
      # document stakeholders

        create  => "true";
}
```
\end{codelisting}

<!---
Filename: 310-050-Knowledge-Management-0300-Dunbar\_numbers.md
-->

### Dunbar numbers

Robin Dunbar pointed out that there are limits to human cognition:

### Limits to Human Congnition:
* We can only have a close relationship to about 5 things.
* We can have a working relationship with about 30 things or people.
* We can only be acquainted with about 150.

The `Dunbar numbers' are cognitive limits that we have to work around.

http://markburgess.org/blog_km.html

\coloredtext{red}{ 310-050-Knowledge-Management-0300-Dunbar\_numbers.md }

