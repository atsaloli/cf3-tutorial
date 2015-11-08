
<!---
Filename: 520-000-Part-Title-0000-Selecting\_Files\_and\_Processes.md
-->

# Selecting Files and Processes

\coloredtext{red}{ 520-000-Part-Title-0000-Selecting\_Files\_and\_Processes.md }


<!---
Filename: 520-060-File\_Selection-0490-title\_card.md
-->

## Selecting Files

\coloredtext{red}{ 520-060-File\_Selection-0490-title\_card.md }

\begin{codelisting}
\codecaption{520-060-File\_Selection-0500-Select\_by\_mode.cf}
```cfengine3, options: "linenos": true

############################################

bundle agent main

{

  files:

      "/tmp/test_from/."

        file_select => mode_777,
        transformer => "/bin/gzip $(this.promiser)",
        depth_search => recurse("inf");

}

############################################

body file_select mode_777

{
        search_mode => { "777" };
        file_result => "mode";
}

############################################

body depth_search recurse(d)

{
        depth => "$(d)";
}

```
\end{codelisting}
\begin{codelisting}
\codecaption{520-060-File\_Selection-0510-Select\_files\_more\_than\_N\_days\_old.cf}
```cfengine3, options: "linenos": true
# The following policy selects files modified over a year ago
#
# It works by selecting files whose mtime is between 1 year old
# and 100 years old.  Next we will show you a more elegant way
# to do it.


bundle agent main

{
  files:

      "/tmp/test_from"

        file_select => modified_over_a_year_ago,
        transformer => "/bin/echo FOUND $(this.promiser)",
        depth_search => recurse("inf");

}

############################################

body file_select modified_over_a_year_ago

{
        mtime => irange(ago(100,0,0,0,0,0),ago(1,0,0,0,0,0));
      # modified between 1-100 years ago
      # Reminder: ago(Years, Months, Days, Hours, Minutes, Seconds)

        file_result => "mtime";
}

############################################

body depth_search recurse(d)

{
        depth => "$(d)";
}

```
\end{codelisting}
\begin{codelisting}
\codecaption{520-060-File\_Selection-0520-Select\_by\_several\_things.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/var/logexample/."

        handle => "remove_world_writable_files",
        file_select => compound_filter,
        depth_search => recurse("inf"),
        delete  => tidy;
}

body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }



body file_select compound_filter

{

        search_mode => { "777" };
        leaf_name => { ".*\.pdf" , ".*\.fdf" };  # leaf_name = regex to match


        file_result => "leaf_name&mode";   # this is a class expression
}

```
\end{codelisting}
\begin{codelisting}
\codecaption{520-060-File\_Selection-0530-Select\_files\_more\_than\_N\_days\_old\_More\_elegant.cf}
```cfengine3, options: "linenos": true
# The following policy selects files modified over a year ago
#
# More elegant version, courtesy of Dan Klein.


bundle agent main

{
  files:

      "/tmp/test_from"

        file_select => modified_over_a_year_ago,
        transformer => "/bin/echo FOUND: $(this.promiser)",
        depth_search => recurse("inf");

}

############################################

body file_select modified_over_a_year_ago

{
        mtime => irange(ago(1,0,0,0,0,0),now);
      # will select files modified between a year ago
      # and now

        file_result => "!mtime";
      # will select files modified over a year ago
      # (inverts the above selection)
}

############################################

body depth_search recurse(d)

{
        depth => "$(d)";
}

```
\end{codelisting}
\begin{codelisting}
\codecaption{520-060-File\_Selection-0540-Compress\_old\_files.cf}
```cfengine3, options: "linenos": true
#######################################################
#
# Searching for permissions
#
#######################################################


############################################

bundle agent main

{
  files:

      "/tmp/test_from"

        file_select => days_old("1"),
        transformer => "/bin/gzip $(this.promiser)",
        depth_search => recurse("inf");

}

############################################

body depth_search recurse(d)

{
        depth => "$(d)";
}

##########################################

body file_select days_old(days)
{
        mtime       => irange(0,ago(0,0,"$(days)",0,0,0));
        file_result => "mtime";
}


```
\end{codelisting}
\begin{codelisting}
\codecaption{520-060-File\_Selection-0550-Compress\_old\_pdf\_files.cf}
```cfengine3, options: "linenos": true
#######################################################
#
# Searching for permissions
#
#######################################################


############################################

bundle agent main

{
  files:

      "/tmp/test_from"

        file_select => compound_filter,
        transformer => "/bin/gzip $(this.promiser)",
        depth_search => recurse("inf");

}

############################################

body file_select compound_filter

{

        leaf_name => { ".*\.pdf" , ".*\.fdf" };
      # leaf_name = regex to match

        mtime => irange(ago(1,0,0,0,0,0),now);
      # modified within 1 year

      # the above automatically define classes
      # only if the right hand side matches
      # file being examined

        file_result => "leaf_name.(!mtime)";
      # this is a class expression using classes
      # defined by the above filters
}

############################################

body depth_search recurse(d)

{
        depth => "$(d)";
}
```
\end{codelisting}

<!---
Filename: 520-070-Process\_Selection-0560-title\_card.md
-->

## Selecting Processes

\coloredtext{red}{ 520-070-Process\_Selection-0560-title\_card.md }

\begin{codelisting}
\codecaption{520-070-Process\_Selection-0570-Kill\_based\_on\_process\_owner\_username.cf}
```cfengine3, options: "linenos": true
# Kill all processes belonging to user "victim".
# For the demonstration, in another window, run:
#    useradd victim && su - victim
# You will see cf-agent kill victim's session.
#
# You can dry-run this with cf-agent --dry-run.


bundle agent main {

  processes:

      ".*"

        process_select   => by_process_owner("victim"),
        signals => { "term", "kill" };

}

########################################################

body process_select by_process_owner(username) {

        process_owner => { "$(username)" };
        process_result => "process_owner";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{520-070-Process\_Selection-0580-Select\_by\_vsize.cf}
```cfengine3, options: "linenos": true
# kill all processes over a certain vsize (total Virtual Memory size in kb)

bundle agent main {

  processes:

      ".*"

        process_select  => vsize_exceeds("30000"),
        signals => { "term", "kill" };

}

########################################################

body process_select vsize_exceeds(vsize_limit) {

        vsize => irange("$(vsize_limit)","inf"); # vsize is over
      # $(vsize_limit)
        process_result => "vsize";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{520-070-Process\_Selection-0590-Select\_by\_process\_owner\_command\_and\_vsize.cf}
```cfengine3, options: "linenos": true
# Scenario: you have a memory leak in your Web app
# that causes "bloat" in httpd processes.
#
# kill all apache httpd processes over a certain vsize
# (vsize = total Virtual Memory size in kb)

bundle agent main {

  processes:

      ".*"

        process_select  => vsize_exceeds("apache",
                                         "/usr/sbin/httpd.*",
                                         "30000"),
        signals => { "term", "kill" };

}

########################################################

body process_select vsize_exceeds(process_owner,
      process_command,
      vsize_limit)
{
        process_owner => { "apache" };
      # username of process owner

        command => "$(process_command)";  # username of process owner

        vsize => irange("$(vsize_limit)","inf"); # vsize is over
      # $(vsize_limit)

        process_result => "process_owner&command&vsize";  # class expression
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{520-070-Process\_Selection-0600-Graceful\_restart\_of\_bloated\_apache\_httpd.cf}
```cfengine3, options: "linenos": true
# Scenario: you have a memory leak in your Web app
# that causes "bloat" in httpd processes.
#
# Issue a graceful restart command to the httpd
# if any apache httpd processes exceed vsize limit
# (vsize = total Virtual Memory size in kb).

bundle agent main {

  processes:

      ".*"

        process_select  => vsize_exceeds("apache", "httpd", "30000"),
        process_count => set_class("big_apache_httpd_procs");

  commands:
    big_apache_httpd_procs::
      "/usr/sbin/httpd -k graceful";


}

########################################################

body process_select vsize_exceeds(process_owner, command, vsize_limit) {

        process_owner => { "apache" };  # username of process owner

        command => "/usr/sbin/httpd.*";  # username of process owner

        vsize => irange("$(vsize_limit)","inf"); # vsize is over
      # $(vsize_limit)
        process_result => "process_owner&command&vsize";
}

########################################################

body process_count set_class(classname)

{
        match_range => "1,inf";
      # Integer range for acceptable number of matches for this process
      # (In this case, one or more processes

        in_range_define => { "$(classname)" };
      # List of classes to define if the matches are in range.
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{520-070-Process\_Selection-0610-Select\_by\_several\_things.cf}
```cfengine3, options: "linenos": true
########################################################
#
# Simple test processes
#
########################################################


bundle agent main

{
  processes:

      ".*"

        process_count   => anyprocs,
        process_select  => proc_finder;


  reports:

    any_procs::

      "Found processes in range";

    in_range::
      "Found no processes in range";

}

########################################################

body process_select proc_finder

{

        command => "vim .*";
        # (Anchored) regular expression matching the CMD field

        stime_range => irange(ago(1,0,0,0,0,0),ago(0,0,0,0,0,10));
        # Processes started between 1 year and 10 seconds ago

        process_owner => { "root" };
        # List of regexes matching the user of a process

        process_result => "stime&command&process_owner";

}

########################################################

body process_count anyprocs

{
        match_range => "0,0";
      # Integer range for acceptable number of matches for this process
      # (In this case, one or more processes

        out_of_range_define => { "any_procs" };
      # List of classes to define if the matches are out of range

        in_range_define => { "in_range" };
      # List of classes to define if the matches are in range.
      # We should never have a process that has a count of 0.

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{520-070-Process\_Selection-0620-Select\_by\_stime.cf}
```cfengine3, options: "linenos": true
bundle agent main

{
  processes:

      ".*sleep.*"

        process_select  => newborns,
        signals => { "term" };



}

########################################################

body process_select newborns

{


        stime_range => irange(ago(0,0,0,1,0,0), now);
      # Processes started between 1 hour and 1 second ago

        process_result => "stime";
}

```
\end{codelisting}
