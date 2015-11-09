
<!---
Filename: 958-000-Part-Title-0000-Additional\_Exercises.md
-->

# Appendix B - Additional Exercises

\coloredtext{red}{ 958-000-Part-Title-0000-Additional\_Exercises.md }

<!---                 
Filename: 958-010-Exercises-0020-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_41}
\heading{Report the current time }


Report the current time using:

1. Output from /bin/date (captured using execresult() function)

2. Built-in special variable $(sys.date)


\end{aside}
\coloredtext{red}{ 958-010-Exercises-0020-Exercise.exr.md }
<!---                 
Filename: 958-010-Exercises-0030-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_42}
\heading{Create (manually) a data file:}


   '/tmp/data.txt'

        line 1
        line 2
        line 3

Use cf-agent to replace "line 2" with "line two".


\end{aside}
\coloredtext{red}{ 958-010-Exercises-0030-Exercise.exr.md }
<!---                 
Filename: 958-010-Exercises-0040-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_43}
\heading{CFEngine template}


1. Manually create a template '/var/cfengine/masterfiles/templates/motd.dat':

```cfengine3
This system is property of __ORGANIZATION__.
Unauthorized use forbidden.
CFEngine maintains this system.
CFEngine last ran on $(sys.date).
```

2. Write a CFEngine policy to generate '/etc/motd' from '/var/cfengine/inputs/templates/motd.dat' as follows:

* Replace __ORGANIZATION__ with the name of your organization.

* Expand the special variable $(sys.date).

Use all of the following promise types:

* delete_lines
* insert_lines
* replace_patterns



\end{aside}
\coloredtext{red}{ 958-010-Exercises-0040-Exercise.exr.md }
<!---                 
Filename: 958-010-Exercises-0050-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_44}
\heading{Distribute policy}


Integrate your motd policy into the default cfengine policy in masterfiles so that it propagates to all servers.


\end{aside}
\coloredtext{red}{ 958-010-Exercises-0050-Exercise.exr.md }
<!---                 
Filename: 958-010-Exercises-0060-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_45}
\heading{Log repairs}


With CFEngine Enterprise, we see all repairs through the Mission Portal.

With the Community Edition, it is helpful to log when a promise is repaired, so we can see what changes CFEngine is making where.

Write a promise that logs when it is repaired to '/var/log/cfengine/repairs.log'

Reference: [CFEngine Special Topics Guide on Reporting](https://auth.cfengine.com/archive/manuals/st-reporting).


\end{aside}
\coloredtext{red}{ 958-010-Exercises-0060-Exercise.exr.md }
<!---                 
Filename: 958-010-Exercises-0070-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_46}
\heading{File editing: preserving a block while inserting it}


Insert the following three lines (and you can keep them in order, as a single block, using insert_lines attribute insert_type => "preserve_block";) into /etc/profile BEFORE the HOSTNAME=... line.  (Hint: look at the "location" attribute of insert_lines)

```bash
if [ -x /bin/custom ]
  then /bin/custom
fi
```



\end{aside}
\coloredtext{red}{ 958-010-Exercises-0070-Exercise.exr.md }
<!---                 
Filename: 958-010-Exercises-0080-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_47}
\heading{Shutdown your VM at the end of the day}


*Problem:*  All practice machines should be shutdown at end of class at 17:00

*Desired state:*  The command '/sbin/shutdown -h now' is running when we are in the 17th hour of the day, so the system shuts down cleanly and on time.


\end{aside}
\coloredtext{red}{ 958-010-Exercises-0080-Exercise.exr.md }
<!---                 
Filename: 958-010-Exercises-0090-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_48}
\heading{File editing: replacing text}


Given a file '/tmp/file.txt':

```text
apples
oranges
```

Use the CFEngine Standard Library to comment out "oranges" and append "bananas", resulting in:

```text
apples
# oranges
bananas
```

Hint: use the following:
* bundle edit_line insert_lines
* bundle edit_line comment_lines_matching


\end{aside}
\coloredtext{red}{ 958-010-Exercises-0090-Exercise.exr.md }
<!---                 
Filename: 958-010-Exercises-0100-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_49}
\heading{Containing commands}


Run the command '/usr/bin/id' as user "nobody".

Hint: use "body contain setuid".


\end{aside}
\coloredtext{red}{ 958-010-Exercises-0100-Exercise.exr.md }
<!---                 
Filename: 958-010-Exercises-0110-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_50}
\heading{Configure sshd}


How does the system look like in the correct configuration:

1. Make sure '/etc/ssh/sshd\_config' contains the line "PermitRootLogin no"

2. Make sure sshd is running using this configuration

How to code it in CFEngine:

1. a files promise to edit sshd\_config

2. a commands promise to restart sshd to reload the new config

Exercise:  use "body classes if\_repaired" to link 1 and 2 above to make sure 2 happens.



\end{aside}
\coloredtext{red}{ 958-010-Exercises-0110-Exercise.exr.md }
<!---                 
Filename: 958-010-Exercises-0120-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_51}
\heading{Reload sshd if config file was updated}


Restart sshd if process start time of sshd predates the modification timestamp of '/etc/ssh/sshd\_config' (Process selection is demonstrated in *Process_Selection* in verticalsysadmin\_training\_examples)

Send the solution to the author for a special prize.


\end{aside}
\coloredtext{red}{ 958-010-Exercises-0120-Exercise.exr.md }
<!---                 
Filename: 958-010-Exercises-0130-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_52}
\heading{Install a wiki}


Write a CFEngine policy to install and configure a Wiki web service.


\end{aside}
\coloredtext{red}{ 958-010-Exercises-0130-Exercise.exr.md }
<!---                 
Filename: 958-010-Exercises-0150-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_53}
\heading{Put your name into a text file}


Write a policy to create /tmp/myname.txt and put your name in it.  


\end{aside}
\coloredtext{red}{ 958-010-Exercises-0150-Exercise.exr.md }
<!---                 
Filename: 958-010-Exercises-0160-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_54}
\heading{Use a CFEngine template}


Create a template by running the following shell command:

```bash
echo 'Hello, $(mybundle.myname).  The time is $(sys.date).' > /tmp/file.dat
```


Note: a fully qualified variable consists of the bundle name wherein the variable is defined plus the variable name.

Example:

```cfengine3
bundle agent mybundle { vars: "myvar" string => "myvalue"; }
```

The fully qualified variable name is `$(mybundle.myvar)`.

Now write a policy to populate contents of /tmp/file.txt using this template file, /tmp/file.dat.

Make sure your bundle defines the variable embedded in the template, and that your bundle name matches the bundle name embedded in the template.

Your policy should use an edit_lines bundle containing an insert_lines promise with the following attributes:

```cfengine3
insert_type => "file",
expand_scalars => "true";
```


\end{aside}
\coloredtext{red}{ 958-010-Exercises-0160-Exercise.exr.md }
<!---                 
Filename: 958-010-Exercises-0170-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_55}
\heading{Set a custom class based on the existence of a file. }


Example:

```cfengine3
    classes:

       "file_exists"

           expression  =>  fileexists("/etc/site_id") ;
```

Then write another promise that is conditional on the above class.

Run it when the file exists, and when it does not, and observe how CFEngine dynamically configures your server.


\end{aside}
\coloredtext{red}{ 958-010-Exercises-0170-Exercise.exr.md }
<!---                 
Filename: 958-010-Exercises-0180-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_56}
\heading{Edit /etc/motd (file editing and classes)}


Part 1

* Write a policy to create '/etc/motd' as follows:

It should *always* say "Unauthorized use forbidden."

Part 2

* '/etc/motd' should *always* say "Unauthorized use forbidden". However, on weekends, it should also say "Go home, it's the weekend".

Test by defining "Saturday" class on the command line:

```bash
cf-agent -D Saturday  --file ... --bundle ...
```


\end{aside}
\coloredtext{red}{ 958-010-Exercises-0180-Exercise.exr.md }
