
<!---
Filename: 500-000-Part-Title-0000-Functions.md
-->

# Functions

See [Functions](https://docs.cfengine.com/latest/reference-functions.html) in the CFEngine Reference for explanation of the following functions.




<!---
Filename: 500-010-Functions-0000-Chapter-Title.md
-->

## CFEngine Functions


\begin{codelisting}
\codecaption{500-010-Functions-0910-putting\_command\_output\_into\_variable.cf}
```cfengine3, options: "linenos": false
bundle agent main {

  vars:
      "my_result"
        string => execresult("/bin/ls /etc/motd /nosuchfile",
                             "noshell");

  reports:

      "Variable is $(my_result)";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{500-010-Functions-0920-function\_countlinesmatching.cf}
```cfengine3, options: "linenos": false
bundle agent main {

  vars:
      "no"
        int => countlinesmatching("^cfengine:.*",
                                  "/etc/group");

  reports:
      "Found $(no) lines matching";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{500-010-Functions-0930-functions\_canonify.cf}
```cfengine3, options: "linenos": false
bundle agent main {

  vars:
      "canonified_text"
        string  => canonify("hello!@#$%world");

  reports:
      "$(canonified_text)";

}

```
\end{codelisting}
\begin{codelisting}
\codecaption{500-010-Functions-0940-get\_info\_from\_env\_variable.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  vars:
      "myvar" string => getenv("USER","20");


  reports:
      "I am running as user $(myvar)"
         if => isvariable("myvar");
}
```
\end{codelisting}

<!---
Filename: 500-010-Functions-0950-exercise.md
-->

Functions exercise

Print a report if /etc/motd is newer than /etc/passwd

---------------

How to convert epoch time to human-readable:

vars:
  "human_ctime"
     string => execresult("/bin/date -d @ $(ctime)", "noshell");

reports:
  "$(human_ctime)";



