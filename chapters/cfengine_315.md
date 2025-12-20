
<!---
Filename: 315-050-Knowledge\_Management-0010-is\_one\_of\_the\_key\_challenges\_of\_scale.md
-->

## Knowledge Management as a Challenge to Scalability

Knowledge Management is one of the key challenges of scale today.

Not lack of CPU, memory or storage - but having sufficient understanding.

How does CFEngine help us address this?



<!---
Filename: 315-050-Knowledge\_Management-0020-promise\_handle.md
-->

## Promise Handles

A promise handle is a short name for a promise -- it's the unique id of a promise.

Handles are essential for mapping dependencies and performing impact analyses.

Promise handles have to follow the rule for CFEngine identifiers:
characters allowed are alphanumerics and underscores only (no spaces).

Reference: <https://docs.cfengine.com/docs/3.12/reference-promise-types.html#handle>


\begin{codelisting}
\codecaption{315-050-Knowledge\_Management-0030-handle.cf}
```cfengine3, options: "linenos": false
# Example of a promise handle

bundle agent main
{
  files:
      "/tmp/testfile"
        handle => "create_testfile", # <-- promise handle 
        create => "true";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{315-050-Knowledge\_Management-0040-duplicate-handle.cf}
```cfengine3, options: "linenos": false
# Promise handles MUST be unique.
#
# The following is NOT valid CFEngine.

bundle agent main
{
  files:
      "/tmp/testfile"
        handle => "create_testfile",
        create  => "true";

  reports:
     "hello world"
       handle => "create_testfile";
}
```
\end{codelisting}

<!---
Filename: 315-050-Knowledge\_Management-0050-depends\_on.md
-->

## Documenting Dependencies

You can use the `depends_on` attribute to document dependencies
and control process flow.

The `depends_on` attribute takes a list of promise handles on the right-hand side.


\begin{codelisting}
\codecaption{315-050-Knowledge\_Management-0060-depends\_on.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  reports:

      "Launch!!"
        depends_on => { "fuel" },  # <-- dependencies
        handle => "launch";

      "Fueling"
        handle => "fuel";
}
```
\end{codelisting}

<!---
Filename: 315-050-Knowledge\_Management-0070-promisee.md
-->

## Promisees

In CFEngine, you can document not only the promiser
(what makes the promise) but also the **promisee**
(to whom the promise is made, or what depends on
that promise).

The following example demostrates that 'fuel'
has a documented impact on 'launch'; and that
'launch' depends on 'fuel'.


\begin{codelisting}
\codecaption{315-050-Knowledge\_Management-0075-promisee\_stakeholders.cf}
```cfengine3, options: "linenos": false
# Documenting the Stakeholders

bundle agent main
{

  files:
      "/etc/httpd/conf/httpd.conf" -> { "Web Services team", "NOC" }
        create  => "true";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{315-050-Knowledge\_Management-0080-promisee\_and\_depends\_on.cf}
```cfengine3, options: "linenos": false
# Documenting what depends on this promise

bundle agent main
{
  reports:

      "Launch!!"
        depends_on => { "fuel" },
        handle => "launch";

      "Fueling" -> { "launch" }   # <-- promisee
        handle => "fuel";
}

```
\end{codelisting}
\begin{codelisting}
\codecaption{315-050-Knowledge\_Management-0090-depends\_on.cf}
```cfengine3, options: "linenos": false
# You can have multiple dependencies

bundle agent main
{
  reports:

      "Launch!!"
        depends_on => { "systems_check", "fuel" },
        handle => "ignition";

      "Systems Check"
        handle => "systems_check";

      "Fueling..."
        handle => "fuel";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{315-050-Knowledge\_Management-0100-multiple\_promisees.cf}
```cfengine3, options: "linenos": false
# You can have multiple promisees

bundle agent main
{
  reports:

      "Systems Check" -> { "fuel", "launch" }
        handle => "systems_check";
}
```
\end{codelisting}

<!---
Filename: 315-050-Knowledge\_Management-0110-depends\_on2.md
-->

Promisees don't control flow.

Only `depends_on` does.

TIP: Try to think declaratively (not imperatively), and use `depends_on`
only when needed.


<!---                 
Filename: 315-050-Knowledge\_Management-0120-flow\_control\_verbose\_mode.exr.md
-->

\begin{aside}
\label{aside:exercise_23}
\heading{Run 310-050-Knowledge_Management-0060-depends_on.cf in verbose mode.}


How many passes through the bundle does it take to report both promises?

On which pass is the "Fueling" report made?

On which pass is the "Launch!!" report made? Why?

```cfengine3
bundle agent main
{
  reports:

      "Launch!!"
        depends_on => { "fuel" },
        handle => "launch";

      "Fueling"
        handle => "fuel";
}
```


\end{aside}

<!---
Filename: 315-050-Knowledge\_Management-0130-comments.md
-->

## Comments

Comments written in code follow the program, they are not merely
discarded; they appear in verbose logs and error messages.


\begin{codelisting}
\codecaption{315-050-Knowledge\_Management-0140-comment.cf}
```cfengine3, options: "linenos": false
# run this in verbose mode and notice the comment

bundle agent main
{
  files:
      "/tmp/testfile"
        comment => "Create a vital file, needed for XYZ.",
        create  => "true";
}
```
\end{codelisting}

<!---
Filename: 315-050-Knowledge\_Management-0150-debug\_reports.md
-->

## Debug Reports

Debug reports can be convenient for debugging all or part of a policy.


\begin{codelisting}
\codecaption{315-050-Knowledge\_Management-0160-debug\_reports.cf}
```cfengine3, options: "linenos": false
# Demonstrate by running this with DEBUG and then with DEBUG_main and
# DEBUG_prep classes to control debug reporting
#
# cf-agent -D DEBUG -f <thisfile>
# cf-agent -K -D DEBUG_main -f <thisfile>
# cf-agent -K -D DEBUG_prep -f <thisfile>

bundle agent main {

  vars:
    "name"
      string => "George";

  methods:
    "prep";

  reports:
    DEBUG|DEBUG_main::
      "DEBUG $(this.bundle)";
      "$(const.t)DEBUG $(this.bundle): name = '$(name)'";
}

bundle agent prep {

reports:
  DEBUG|DEBUG_prep::
      "DEBUG $(this.bundle)";
      "$(const.t)DEBUG $(this.bundle): foo = 'bar'";
}
```
\end{codelisting}

<!---
Filename: 315-050-Knowledge\_Management-0180-Dunbar\_numbers.md
-->

## Dunbar Numbers

Robin Dunbar pointed out that there are limits to human cognition:

* We can only have a close relationship to about 5 things.
* We can have a working relationship with about 30 things or people.
* We can only be acquainted with about 150.

The `Dunbar numbers' are cognitive limits that we have to work around.

See Mark Burgess's ["Notes from the USENIX/LISA Knowledge Management Workshop"](http://markburgess.org/blog_km.html)

You can use this to structure CFEngine policy.



<!---
Filename: 315-050-Part-Title-0000-Knowledge\_Management.md
-->

# Knowledge Management


