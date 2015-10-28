
<!---
Filename: 420-000-Part-Title-0000-CFEngine\_Standard\_Library.md
-->

# CFEngine Standard Library



<!---
Filename: 420-060-COPBL-0000-Chapter-Title.md
-->

## CFEngine Standard Library



<!---
Filename: 420-060-COPBL-0460-Introduction.md
-->

CFEngine ships with a standard library of promise bodies and bundles dealing with common aspects of system administration.  

The CFEngine Standard Library is growing to include all common aspects of system administration. 

<!---
[header]
|##################========================================
| CFEngine version | Promise bodies | Promise  bundles
| *3.1.5*            | 88             | ?
| *3.2.1*            | 99             | 19  
| *3.3.5*            | 114            | 29
| *3.3.8*            | 113            | 26
| *3.4.4*            | 124            | 32
|##################========================================
-->


\begin{codelisting}
\codecaption{420-060-COPBL-0470-Package\_add\_using\_COPBL.cf}
```cfengine3, options: "linenos": true
#reports:
# "sys.libdir = $(sys.libdir)/stdlib.cf" ;


#NEEDS TO BE UPDATED TO 3.7 SYNTAX

bundle agent main {

reports:
 "sys.libdir = $(sys.libdir)/stdlib.cf" ;
}
#  packages:
# 
#       "php-mysql"
# 
#         handle => "install_package_php_mysql",
#         comment => "Demonstrate installing a package",
#         package_policy => "add",
#         package_method => yum;
# 

#############################################

#body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0480-File\_Exists\_And\_Is\_Mode\_612\_Without\_COPBL.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/tmp/testfile"

        handle  => "set_file_attributes",
        comment => "Demonstrate setting file attributes",
        create  => "true",
        perms   => mog("612","aleksey","cfengine");

}

############################################################

body perms mog(mode,owner,group)
{
        owners => { "$(owner)", "john", "brian" };
        mode   => "$(mode)";
        groups => { "$(group)" };
}

```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0490-File\_exists\_and\_is\_mode\_6\_1\_2\_mog.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/tmp/testfile"

        handle => "set_file_attributes",
        comment => "/tmp/testfile must be mode 612 for application X
                          to work; it must be owned by user 'aleksey' and
                          group 'cfengine'",
        create  => "true",
        perms   => mog("612","aleksey","cfengine");

}

###########################################################

body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0500-Context\_sensitive\_file\_editing\_Set\_robs\_password.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/etc/shadow"
        handle => "context_sensitive_file_editing_demo",
        comment => "demonstrate context-sensitive file editing capability",
        edit_line => set_user_field("rob",
                                    "2",
                                    "$1$stIAaUZw$ptP75nVkz/EapeuvdWLNC0");
}

#body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
body file control { inputs => { "/var/cfengine/inputs/lib/3.6/stdlib.cf" }; }
```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0510-Removing\_a\_file.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/tmp/testfile.*"

        handle => "demo_removing_files",
        comment => "Demonstrate removing files using body delete tidy",
        delete => tidy;

      # shell equivalent:  rm -r /tmp/testfile*

}


body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}

<!---
Filename: 420-060-COPBL-0520-Comment\_Out\_A\_File.exr.md
-->

Run the following command:

```bash
date  > /tmp/date.txt
```

Now write a CFEngine policy that will comment out (using #) the contents of that file.



\begin{codelisting}
\codecaption{420-060-COPBL-0530-Commenting\_out\_file\_contents.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/etc/httpd/conf.d/maintenance.conf"

        handle    => "take_website_out_of_maintenance",
        comment   => "Disable maintenance-mode config block",
        edit_line => comment_out_everything;

}

bundle edit_line comment_out_everything {

  replace_patterns:

      "^([^#].*)"
        replace_with => comment("# ");
}

body replace_with comment(c)
{
        replace_value => "$(c) $(match.1)";
        occurrences => "all";
}


```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0540-Z.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/etc/httpd/conf.d/maintenance.conf"

        handle    => "put_website_into_maintenance",
        comment   => "Enable maintenance-mode config block",
        edit_line => uncomment_everything;

}

bundle edit_line uncomment_everything {

  replace_patterns:

      "^#(.*)"
        handle => "uncomment_everything_replace_pattern",
        comment => "If it starts with a hash mark, grab everything
                          after the hash mark, and uncomment it.",
        replace_with => uncomment;
}


body replace_with uncomment
{
        replace_value => "$(match.1)";
        occurrences => "all";
}


```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0550-Removing\_a\_file\_Remove\_centos\_httpd\_welcome\_page.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/etc/httpd/conf.d/welcome.conf"

        handle => "nuke_welcome_conf",
        comment => "Let's keep a low profile and not advertise
                          what software we are running - remove the
                          Welcome page that says we are running Apache
                          on CentOS",
        delete => tidy;
}


body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0560-Remove\_httpd\_welcome\_page\_by\_commenting\_out\_welcome\_conf.cf}
```cfengine3, options: "linenos": true
# welcome.conf is part of the Apache RPM
# to preserve package integrity, comment out this file's contents
# instead of deleting the file

bundle agent main {

  files:

      "/etc/httpd/conf.d/welcome.conf"

        handle => "comment_out_welcome_dot_conf",
        comment => "Let's not ask for trouble by advertising
                          what software we are running",
        edit_line => comment_out_everything,
        classes => if_repaired("reload_httpd");

  commands:
    reload_httpd::
      "/etc/init.d/httpd"
        handle => "cmd_reload_httpd",
        comment => "Reload httpd configuration",
        args => "reload";

}

bundle edit_line comment_out_everything {

  replace_patterns:

      "^([^#].*)"

        handle => "comment_out_everything_replace_patterns_promise",
        comment => "If it doesn't start with #, comment it out",
        replace_with => comment("#disabled-by-cfengine# ");

}

body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0590-classes\_if\_else.cf}
```cfengine3, options: "linenos": true
bundle agent main {


  files:

      "/tmp/etc/motd"
        handle => "touch_file",
        comment => "Demonstrate body classes if_else",
        create => "true",
        classes => if_else("file_exists","file_missing");

  reports:
    file_exists::
      "All OK"
        handle => "report_OK";

  reports:
    file_missing::
      "WARNING! Unable to create vital file!"
        handle => "report_WARN";

}


body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0600-classes\_persistent.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:
      "/tmp/file.txt"
        handle => "persistent_class_demo",
        comment => "Set a persistent class",
        create => "true",
        classes  => state_repaired("file_fixed");

  reports:
    file_fixed::
      "Persistent class set.  Run in verbose mode to see TTL"
        handle => "report_success",
        comment => "Report if our persistent class persistent_class
                          has been set as expected.";
}

body classes state_repaired(x)
{
        promise_repaired => { "$(x)" };
        persist_time => "10";
}


```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0610-comment\_lines\_matching.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:
      "/tmp/scratch"
        handle => "selective_commenting",
        comment => "Remove specific lines",
        edit_line => comment_lines_matching("hello world", "#");

}


body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0620-contain\_silent.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  commands:

      "/bin/date"
        handle => "run_date_cmd",
        comment => "Demonstrate 'body contain silent'",
        contain => silent;


}

body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0630-edit\_line\_insert\_lines.cf}
```cfengine3, options: "linenos": true
!! SKIP !!

bundle agent main {

  files:
      "/etc/profile"
        handle => "edit_etc_profile",
        create => "true",
        edit_line => insert_lines("export ORGANIZATION=ACME");

}


body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0640-edit\_resolv\_dot\_conf\_using\_COPBL.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:

      "search_suffix"  string =>  "example.com example2.com";

      "nameservers"    slist  =>  { "8.8.4.4", "8.8.8.8" };

  files:

      "/tmp/resolv.conf"

        handle =>  "edit_resolv_conf",
        comment => "Setup up DNS resolver",
        edit_line =>  resolvconf("$(search_suffix)",
                                 "@(example.nameservers)" );
}


body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0660-insert\_lines.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/tmp/scratch"

        handle => "files_multi_line_insert",
        comment => "Insert multi-line content",
        create => "true",
        edit_line => insert_lines("
hello world
this is line 2
line 3 is great
line 4 is awesome
");
}


body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0680-set\_variable\_values.cf}
```cfengine3, options: "linenos": true
bundle common global {

  vars:

      "stuff[location]"     string => "Bloomington";
      "stuff[time]"         string => "May-2013";
      "stuff[students]"     string => "11";
      "stuff[lab]"          string => "true";
}

bundle agent main {

  files:

      "/etc/example.conf"
        handle => "populate_config_file_from_array",
        comment => "Demonstrate 'bundle edit_line set_variable_values'",
        create => "true",
        edit_line => set_variable_values("global.stuff");
}


body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }
```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0690-standard\_services.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  methods:

    any::

      "Manage www service"

        usebundle => standard_services ("www", "stop");

}

bundle agent standard_services(service,state)
{

      # DATA

  vars:

    any::

      "stakeholders[www]" slist => { "www_in", "wwws_in", "www_alt_in" };


    SuSE|suse|debian::

      "startcommand[www]" string => "/etc/init.d/apache2 start";
      "stopcommand[www]"  string => "/etc/init.d/apache2 stop";
      "pattern[www]"      string => ".*apache2.*";


    redhat::

      "startcommand[www]" string => "/etc/init.d/httpd start";
      "stopcommand[www]"  string => "/etc/init.d/httpd stop";
      "pattern[www]"      string => ".*httpd.*";


      # Implementation details (to implement the DATA above)

  classes:

      "start" expression => strcmp("start","$(state)"),
        comment => "Check if to start a service";
      "stop"  expression => strcmp("stop","$(state)"),
        comment => "Check if to stop a service";


  processes:

    start::

      "$(pattern[$(service)])" ->  { "@(stakeholders[$(service)])" } ,

        comment => "Verify service appears in process table",
        restart_class => "restart_$(service)";

    stop::

      "$(pattern[$(service)])" -> { "@(stakeholders[$(service)])" },

        comment => "Verify service does not appear in process table",
        process_stop => "$(stopcommand[$(service)])",
        signals => { "term", "kill"};

  commands:

      "$(startcommand[$(service)])" -> { "@(stakeholders[$(service)])" },

        comment => "Execute command to restart service '$(service)'",
        ifvarclass => "restart_$(service)";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{420-060-COPBL-0700-modified\_set\_variable\_values.cf}
```cfengine3, options: "linenos": true
# this file contains a modified set_variable_values bundle.
# the main difference is you won't get lines like
# "name =value2" if you start with "name = value1".
# Instead you get lines like "name=value2".

bundle common global {

  vars:

      "stuff[Location]" string => "Chicago";
      "stuff[Time]"     string => "Monday, April 2nd";
}



bundle agent main {

  files:

      "/tmp/example"
        create => "true",
        edit_line => set_variable_values("global.stuff");
}


bundle edit_line set_variable_values(v)

{
  vars:

      "index" slist => getindices("$(v)");

  field_edits:

      # match a line starting like the key *BLANK SPACE* = something

      "\s*$(index)\s+=.*"

        edit_field => col("=","1","$(index)","set"),
        comment => "Edit name=value definition, if there is
                          whitespace after the name to eliminate
                          said whitespace otherwise our insert_lines
                          promise would create a duplicate name=value
                          entry WITHOUT whitespace.";

      # match a line starting like the key = something

      "\s*$(index)=.*"

        edit_field => col("=","2","$($(v)[$(index)])","set"),
        comment => "Edit name=value definition to set the value.
                          Incidentally, this gets rid of any whitespace
                          after the equals sign.";

  insert_lines:

      "$(index)=$($(v)[$(index)])",

        comment => "Insert name=value definition";
}

body edit_field col(split,col,newval,method)
{
        field_separator    => "$(split)";
        select_field       => "$(col)";
        value_separator    => ",";
        field_value        => "$(newval)";
        field_operation    => "$(method)";
        extend_fields      => "true";
        allow_blank_fields => "true";
}

body replace_with value(x)
{
        replace_value => "$(x)";
        occurrences => "all";
}

```
\end{codelisting}
