
<!---
Filename: 500-000-Part-Title-0000-Functions.md
-->

# Functions

See [Functions](https://docs.cfengine.com/latest/reference-functions.html) in the CFEngine Reference for explanation of the following functions.


\coloredtext{red}{ 500-000-Part-Title-0000-Functions.md }


<!---
Filename: 500-010-Functions-0000-Chapter-Title.md
-->

## CFEngine Functions

\coloredtext{red}{ 500-010-Functions-0000-Chapter-Title.md }

\begin{codelisting}
\codecaption{500-010-Functions-0910-putting\_command\_output\_into\_variable.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:
      "my_result"
        string => execresult("/bin/ls /tmp", "noshell");

  reports:

      "Variable is $(my_result)";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{500-010-Functions-0920-function\_countlinesmatching.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:
      "no" int => countlinesmatching("^cfengine:.*","/etc/group");

  commands:
      "/bin/echo"
        args => "Found $(no) lines matching";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{500-010-Functions-0930-functions\_canonify.cf}
```cfengine3, options: "linenos": true
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
```cfengine3, options: "linenos": true
bundle agent main
{
  vars:

      "myvar" string => getenv("USER","20");


  classes:

      "isdefined" not => strcmp("$(myvar)","");

  reports:
    isdefined::
      "I am running as user $(myvar)";

}
```
\end{codelisting}
