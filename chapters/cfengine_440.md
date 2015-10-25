
<!---
Filename: 440-000-Part-Title-0000-Patterns.md
-->

# Patterns

Patterns are a way of compressing information.

The CFEngine 3 language is made of promises and patterns; it’s about using patterns to create concise but powerful promises.




<!---
Filename: 440-070-Patterns-0000-Chapter-Title.md
-->

## Patterns + Promises = Configuration



<!---
Filename: 440-070-Patterns-0700-Lists.md
-->

## Lists

An example of a pattern in CFEngine is a list.  You can have a list of things you want, or do not want: for example, a list of packages that should be installed, or processes that should NOT be running.

Implicit looping creates multiple promises that follow the promise pattern.


\begin{codelisting}
\codecaption{440-070-Patterns-0710-Lists\_Implicit\_looping\_over\_a\_list\_of\_packages.cf}
```cfengine3, options: "linenos": true
bundle agent main {

      ######################################################
      # This is the data section, which describes the desired pattern
      #
      # All you do is add to or edit the list...
      #
      # This is *data-driven* configuration.
      ######################################################
  vars:

      "desired_package"

        handle => "good_packages",
        comment => "list the packages we want",
        slist => {
                   "httpd",
                   "php",
                   "php-mysql",
                   "mysql-server",
        };


      "unwanted_package"

        handle => "bad_packages",
        comment => "list the packages we do not want",
        slist => {
                   "java",
                   "ruby",
        };

      ######################################################
      # Below here is stock convergent code, forget this...
      ######################################################

  packages:
      "$(desired_package)"
        handle => "add_package",
        comment => "Ensure package is present",
        package_policy => "add",
        package_architectures => { "x86_64" },
        package_method => yum;


  packages:
      "$(unwanted_package)"
        handle => "remove_package",
        comment => "Ensure package is absent",
        package_policy => "delete",
        package_architectures => { "x86_64" },
        package_method => yum;

}

body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}
\begin{codelisting}
\codecaption{440-070-Patterns-0720-Lists\_Implicit\_looping\_over\_a\_list\_of\_files.cf}
```cfengine3, options: "linenos": true
body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }

bundle agent main {

  vars:

      "list_of_files"
        handle => "file_list",
        comment => "Just a file list",
        slist => {
                   "/etc/passwd",
                   "/etc/group",
        };

  files:

      "$(list_of_files)"

        handle => "set_mode_and_ownership",
        comment => "Ensure a list of files is owned by root
and mode 644",
        perms => mo("644","root");
}
```
\end{codelisting}

<!---
Filename: 440-070-Patterns-0730-Regular\_expressions.md
-->

## Regular Expressions

Regular Expressions is another way of writing patterns.

CFEngine supports POSIX and PCRE regular expressions.  (PCRE by default.)



\begin{codelisting}
\codecaption{440-070-Patterns-0740-Regular\_expressions\_Files.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/etc/pass.*"

        handle => "set_file_perms_on_regex_list_of_files",
        comment => "Files matching /etc/pass.* need to be owned
                          by root and mode 644",
        perms => mo("644","root");

}


body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}

<!---
Filename: 440-070-Patterns-0750-Body\_templates.md
-->

## External Body Parts

> A pattern is just a repeated structure. The benefit of seeing patterns is economy: if you can see a pattern, you can take out the commonality, abstract it, and talk about the pattern instead of all the individual cases. This is a Knowledge Management step.
>
> --- cfengine.org

External body parts are intended to aid in such abstraction.



<!---
Filename: 440-070-Patterns-0760-Classes.md
-->

## Classes
This chapter discusses Classes.


\begin{codelisting}
\codecaption{440-070-Patterns-0770-Classes\_using\_classes\_to\_link\_promises\_BONUS\_logme.cf}
```cfengine3, options: "linenos": true
# Demonstrate using classes to link promises
# also demonstrates action logme

bundle agent main {

  files:
      "/etc/ssh/sshd_config"
        handle => "sshd_must_use_protocol_2_only",
        comment => "Make sure SSHD does not use protocol v1;
                          make sure it only uses protocol v2,
                          to increase security",
        edit_line => permit_protocol_2_only,
        classes => if_repaired("sshd_config_file_was_repaired"),
        action => logme("promise $(this.handle)");

  commands:
    sshd_config_file_was_repaired::
      "/etc/init.d/sshd reload"
        handle => "reload_sshd",
        comment => "run sshd init script to reload sshd
                          to pick up new config",
        action => logme("promise $(this.handle)");

}


body action logme(x)
{
        log_string => "$(sys.date) $(x)";

        log_kept => "/var/log/cfengine_keptlog.log";
        log_repaired => "/var/log/cfengine_replog.log";
        log_failed => "/var/log/cfengine_faillog.log";

}



bundle edit_line permit_protocol_2_only {
      delete_lines: ".*Protocol.*1.*";
      insert_lines: "Protocol 2";
}

body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}
\begin{codelisting}
\codecaption{440-070-Patterns-0780-Classes\_ORing\_of\_classes\_and\_fileexists.cf}
```cfengine3, options: "linenos": true
bundle agent main
{

  classes:

      # List form of class expression useful for including functions

      "my_new_class"

        handle => "or_list",
        comment => "Demonstrate list form of class expression
                          useful for including functions",
        or   => { "linux",
                  "solaris",
                  fileexists("/etc/fstab")
        };


  reports:

    my_new_class::

      # This will only report Boo! on linux, solaris, or any system
      # on which the file /etc/fstab exists

      "Boo!";
}

```
\end{codelisting}
\begin{codelisting}
\codecaption{440-070-Patterns-0790-Classes\_Set\_a\_private\_class\_based\_on\_hard\_classes\_expression.cf}
```cfengine3, options: "linenos": true
bundle agent main {


  classes:

      "good_technology"
        handle => "good_technology_class",
        comment => "Set a custom class based on built-in classes",
        expression => "linux|solaris";

  reports:
    good_technology::
      "I love good technology"
        handle => "show_respect",
        comment => "Show respect for good technology";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{440-070-Patterns-0800-Classes\_Set\_a\_custom\_class\_based\_on\_function\_result.cf}
```cfengine3, options: "linenos": true
# - demonstrate setting a custom class using a function

bundle agent main {

  classes:
      "islink"
        handle => "class_islink",
        comment => "Test if /tmp/a is a symbolic link",
        expression => islink("/tmp/a");


  reports:
    islink::
      "/tmp/a is a link";

    !islink::
      "/tmp/a is not a link";
}
```
\end{codelisting}

<!---
Filename: 440-070-Patterns-0810-Classes\_Default\_classes\_cf\_monitord.md
-->

### Example of classes provided by cf-monitord

If you are running cf-monitord, you may also see entropy and anomaly detection classes:

### entropy

```text
entropy_cfengine_in_low
entropy_cfengine_out_low
entropy_dns_in_low
entropy_dns_out_low
entropy_ftp_in_low
entropy_ftp_out_low
entropy_icmp_in_low
entropy_icmp_out_low
entropy_irc_in_low
entropy_irc_out_low
entropy_misc_in_low
entropy_misc_out_low
entropy_netbiosdgm_in_low
entropy_netbiosdgm_out_low
entropy_netbiosns_in_low
entropy_netbiosns_out_low
entropy_netbiosssn_in_low
entropy_netbiosssn_out_low
entropy_nfsd_in_low
entropy_nfsd_out_low
entropy_smtp_in_low
entropy_smtp_out_low
entropy_tcpack_in_low
entropy_tcpack_out_low
entropy_tcpfin_in_low
entropy_tcpfin_out_low
entropy_tcpsyn_in_low
entropy_tcpsyn_out_low
entropy_udp_in_low
entropy_udp_out_low
entropy_www_in_low
entropy_www_out_low
entropy_wwws_in_low
entropy_wwws_out_low
```

A low entropy value means that most of the events came from only a few (or one) IP addresses. A high entropy value implies that the events were spread over many IP sources.


### Anomaly Detection Example Classes:

`loadavg_high_ldt` - load average higher than usual (based on Leap-Detection Test)

`messages_high_dev1` - the current value of the metric is more than 1 standard deviation above the average.

etc.

Reference: http://www.iu.hio.no/cfengine/docs/cfengine-Anomalies.pdf


\begin{codelisting}
\codecaption{440-070-Patterns-0820-Classes\_Report\_type\_of\_weekday\_Uses\_a\_custom\_class.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  classes:
      "weekday"
        expression => "Monday|Tuesday|Wednesday|Thursday|Friday";


      "weekend"
        expression => "Saturday|Sunday";

  reports:
    weekday::
      "Today is a weekday.";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{440-070-Patterns-0830-Classes\_Report\_type\_of\_weekday\_Uses\_ifvarclass.cf}
```cfengine3, options: "linenos": true
# report "Hello world!  I love weekends!" on Saturday or Sunday,
# report "Hello world!  I love Mondays|Tuesdays|...|Fridays on a weekday

bundle agent main {

  vars:
      "days"
        handle => "days",
        comment => "Build a list of days to report day of the week",
        slist => { "Monday",
                   "Tuesday",
                   "Wednesday",
                   "Thursday",
                   "Friday",
                   "Saturday",
                   "Sunday",
        };


  reports:
      "Hello world!  I love $(days)s!"
        comment => "Report day of the week",
        ifvarclass => "$(days)";


}
```
\end{codelisting}
\begin{codelisting}
\codecaption{440-070-Patterns-0840-Classes\_GOTCHA.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  commands:


    linux&Hr08::

      "/bin/echo Linux system AND we are in the 8th hour.";

      "/bin/echo hello world";   # this promise is NOT in the class "any" !!!

}
```
\end{codelisting}

<!---
Filename: 440-070-Patterns-0850-Classes.exr.md
-->

* Set a custom class if the file '/tmp/testme' exists.

* Report the presence or absense of the file using "reports" type promises and the class defined in #1 above.

* Have a "files" type promise create the file '/tmp/testme'.

* Now, remove '/tmp/testme' and run your policy and observe and explain what happens.



<!---
Filename: 440-070-Patterns-0860-Classes\_Scope.md
-->

### Note: Classes have Scope


\begin{codelisting}
\codecaption{440-070-Patterns-0870-Classes\_Scope.cf}
```cfengine3, options: "linenos": true
bundle agent example_1 {

  classes:
      "its_monday"
        expression => "Monday";

  classes:
      "its_wed"
        expression => "Wednesday";
  classes:
      "its_thur"
        expression => "Thursday";
}


bundle agent example_2 {

  reports:
    its_monday::
      "Yay!  I love Mondays!";

  reports:
    its_wed::
      "Yay!  I love Wednesdays!";

  reports:
    its_thur::
      "Yay!  I love Thursdays!";
}

```
\end{codelisting}
\begin{codelisting}
\codecaption{440-070-Patterns-0880-Classes\_Classes\_defined\_in\_common\_bundles\_have\_global\_scope.cf}
```cfengine3, options: "linenos": true
bundle common global_definitions {

  classes:
      "myclass"
        expression => "any";

}


bundle agent main {

  reports:
    myclass::
      "Yay!  myclass is set";

}

```
\end{codelisting}
\begin{codelisting}
\codecaption{440-070-Patterns-0890-Classes\_if\_repaired\_creates\_global\_classes.cf}
```cfengine3, options: "linenos": true
bundle agent example_1 {

  files:
      "/tmp/motd"
        create => "true",
        classes => if_repaired("its_wed");

}


bundle agent example_2 {

  reports:
    its_wed::
      "Yay!  I love Wednesdays!";

}

body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}
\begin{codelisting}
\codecaption{440-070-Patterns-0900-Classes\_Global\_vs\_local\_classes.cf}
```cfengine3, options: "linenos": true
# Classes defined in common bundles are global.
#
# They appear in the Defined Classes section at the start of
# verbose output.
#
# Classes defined in all other bundles are local

bundle common global_classes {

  classes:

      "webserver"

        expression  =>  classmatch("web[0-9]+");

}



bundle agent main {
  methods:
      "any" usebundle => example_1;
      "any" usebundle => example_2;
}

bundle agent example_1
{

  classes:
      "local_class"
        expression  =>  classmatch("web[0-9]+");

  reports:
    webserver::
      "bundle 'example_1': I am a Web server (global class)";

  reports:
    local_class::
      "bundle 'example_1': I am a Web server (local class)";

}


bundle agent example_2
{

  reports:
    webserver::
      "bundle 'example_2': I am a Web server (global class)";

  reports:
    local_class::
      "bundle 'example_2': I am a Web server (local class)";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{440-070-Patterns-0910-Classes\_Global\_vs\_local\_classes\_local\_demo.cf}
```cfengine3, options: "linenos": true
body common control {

        bundlesequence => { "example_1", "example2" };

}



bundle agent global_classes {

      # Classes defined in common bundles are global.
      #
      # They appear in the Defined Classes section at the start of
      # verbose output.
      #
      # Classes defined in all other bundles are local


  classes:

      "webserver"

        expression  =>  classmatch("web[0-9]+");

}




bundle agent example_1
{

  classes:

      "webserver"

        expression  =>  classmatch("web[0-9]+");


  reports:

    webserver::

      "I am a Web server - 1";

}


bundle agent example_2
{

  reports:

    webserver::

      "I am a Web server - 2";

}

```
\end{codelisting}

<!---
Filename: 440-080-Methods-0000-Chapter-Title.md
-->

## Methods



<!---
Filename: 440-080-Methods-0010-A\_special\_promise\_type.md
-->

There is a special promise type in CFEngine 3 called "methods" that promises to call another promise bundle.  

```cfengine3
 methods:

        "any"

           usebundle => bundle_name;
```


The promiser can be any word, right now it does not matter; the promiser is reserved for future development.

Parameters are optional:

```cfengine3
 methods:

        "any"

           usebundle => bundle_name("arg1", "arg2");
```


\begin{codelisting}
\codecaption{440-080-Methods-0020-Simple\_example.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:

      "userlist" slist => { "alex", "ben", "charlie", "diana", "rob" };


  methods:

      "any" usebundle => remove_user("$(userlist)");

}

###########################################

bundle agent remove_user(user) {

  commands:

      "/usr/sbin/userdel $(user)"
        contain => silent;

}


body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}
\begin{codelisting}
\codecaption{440-080-Methods-0030-Lock\_an\_account.cf}
```cfengine3, options: "linenos": true
body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }

bundle agent main {

  vars:

      "badusers" slist => {
                            "alex",
                            "ben",
                            "charlie",
                            "diana",
                            "joe"
      };

      #####################################################

  methods:

      "any" usebundle => lock_user(@(badusers));

}

###########################################

bundle agent lock_user(user) {

  files:
      "/etc/shadow"

        edit_line => set_user_field("$(user)",2,"!LOCKED");

  files:

      "/etc/passwd"

        edit_line => set_user_field("$(user)",7,"/bin/false");

  files:

      "/etc/sudoers"

        edit_line => delete_lines_matching("^$(user)");

}
```
\end{codelisting}

<!---
Filename: 440-080-Methods-0040-Encapsulation.md
-->

### Methods provide encapsulation of multiple issues

Methods offer powerful ways to encapsulate multiple issues pertaining to a set of parameters. 

For example:

### Removing a user:
* userdel
* sudoers
* mail spool


\begin{codelisting}
\codecaption{440-080-Methods-1010-Abstraction\_using\_methods.cf}
```cfengine3, options: "linenos": true
# Make sure /etc/group contains a "cfengine" group

bundle agent main {

  methods:

      "any"

        handle => "group_exists",
        comment => "make sure the specified group is always present",
        usebundle => groupadd("cfengine");

}


#####################################################################


bundle agent groupadd(groupname) {


  commands:
      linux:: "/usr/sbin/groupadd" args => "$(groupname)";
      aix::   "/sbin/addgroup"     args => "$(groupname)";
      hpux::  "/usr/sbin/addgroup" args => "$(groupname)";

}
```
\end{codelisting}

<!---
Filename: 440-080-Methods-1020-Methods.exr.md
-->

Practice using "methods" type promises

* Write a policy that has two bundles.

  * The first bundle does something visible (such as a reports type promise that says "bundle1") AND calls the second bundle.

  * The second bundle reports "bundle2".

What output will you see and in what order?  Why?  Now run your policy and check.



<!---
Filename: 440-080-Methods-1920-Methods.exr.md
-->

Now parameterize the 2nd bundle -- have the first bundle feed it an argument, and have the 2nd bundle display that argument.



<!---
Filename: 440-080-Methods-1930-Methods.exr.md
-->

Sysadmin Problem:

'/etc/profile' should set the ORGANIZATION environment variable when users log in:

```bash
export ORGANIZATION=MyOrg
```

Policy Writing Exercise:

Write a bundle "etc_profile_contains" that would take an argument and ensure '/etc/profile' contains the text string specified in the argument.

Demonstrate its use by calling it from another bundle:

```cfengine3
    bundle agent example {
       methods:
         "any"
             usebundle => etc_profile_contains("export ORGANIZATION=MyOrg");
    }
```



<!---
Filename: 440-080-Methods-1940-Methods.exr.md
-->

Make a bundle called file_contains that takes two arguments: a filename, and a text string.  The bundle should ensure that the file specified in the first argument contains the text string specified in the second argument.

Example:

```cfengine3
    methods:
     "any" usebundle => file_contains("/etc/profile", "export ORGANIZATION=MyOrg");
     "any" usebundle => file_contains("/etc/motd", "Unauth. use forbidden");
```



<!---
Filename: 440-080-Methods-1950-Methods.exr.md
-->

Configuring a web server.

Write a bundle "webserver" that will ensure an Apache httpd package is installed and process is running if its argument is "on":

```cfengine3
     methods:

        "any"

             usebundle => webserver("on");
```

Then, make sure httpd is not running if its argument is "off".

TIP: The CFEngine function strcmp() can compare two strings.

NOTE: Reference: 039-0085_Basic_Examples:_Classes_and_Reports.__soft-class.cf


