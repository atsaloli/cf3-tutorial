
<!---
Filename: 400-000-Part-Title-0000-CFEngine\_Syntax.md
-->

# Promise Body Parts

\coloredtext{red}{ 400-000-Part-Title-0000-CFEngine\_Syntax.md }


<!---
Filename: 400-010-Body\_Parts-0000-Chapter-Title.md
-->

## Body Parts

\coloredtext{red}{ 400-010-Body\_Parts-0000-Chapter-Title.md }

\begin{codelisting}
\codecaption{400-010-Body\_Parts-0010-Introduction.cf}
```cfengine3, options: "linenos": true
body type name {

        attribute1 => value1;
        attribute2 => value2;
      ...
        attributeN => valueN;
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{400-010-Body\_Parts-0500-Parts\_No\_world\_write\_bit.cf}
```cfengine3, options: "linenos": true
# run "groupadd project_team" to create the group
# "project_team" for this example

bundle agent main {

  files:

      "/tmp/file1"
        create => "true",
        perms   => project_files;

      "/tmp/file2"
        create => "true",
        perms   => project_files;

}

#######################################################

body perms project_files
{
        mode   => "770";
        owners => { "root" };
        groups => { "project_team" };
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{400-010-Body\_Parts-0540-Parts\_Setting\_group\_ownership\_based\_on\_OS.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/tmp/testfile"
        comment  => "Set appropriate file attributes for Admin group
                     on every type of OS",
        create  => "true",
        perms   => admin_group;
}

body perms admin_group {

      linux::  groups => { "wheel" };
      darwin:: groups => { "admin" };
      sunos::  groups => { "sys" };

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{400-010-Body\_Parts-0545-parameterized\_body.cf}
```cfengine3, options: "linenos": true
# Two bundles sharing a body-part that automagically sets
# the correct group ownership based on OS

bundle agent main {

  files:

      "/tmp/testfile"
        handle  => "set_file_attributes_automagically",
        comment  => "Set appropriate file attributes everywhere",
        create  => "true",
        perms   => set_mode_700_admin_group_and_specified_user("sam");

}

body perms set_mode_700_admin_group_and_specified_user(user) {
        mode   => "0700";
        owners => { "$(user)" };

      linux::  groups => { "wheel" };
      darwin:: groups => { "admin" };
      sunos::  groups => { "sys" };
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{400-010-Body\_Parts-0550-Parts\_Replacing\_Patterns.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:
      "/tmp/data.txt"
        handle    => "turn_dogs_into_cats",
        comment   => "Demonstrate search-and-replace in a file",
        edit_line => transform_dogs_to_cats;
}

bundle edit_line transform_dogs_to_cats {

  replace_patterns:
      "[Dd]og"
        replace_with => value("cat");
}

body replace_with value(x) {

        replace_value => "$(x)";
        occurrences => "all";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{400-010-Body\_Parts-0580-perms.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/tmp/testfile"

        perms => not_world_writable_and_right_group;

}

body perms not_world_writable_and_right_group {

        groups => {"root", "games", "mail" };
        mode   => "o-w";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{400-010-Body\_Parts-0590-perms.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/tmp/bobsfile"

        create  => "true",
        comment => "Set mode, ownership and group on /tmp/bobsfile",
        perms   => set_file_attributes("777", "bob", "mail");

      "/tmp/susansfile"

        create  => "true",
        comment => "Set mode, ownership and group on /tmp/susansfile",
        perms   => set_file_attributes("000", "susan", "games");
}

#######################################################

body perms set_file_attributes(mode,owner,group)
{
        mode    => "$(mode)";
        owners  =>  {"$(owner)"};
        groups  =>  {"$(group)"};
}
```
\end{codelisting}
<!---                 
Filename: 400-010-Body\_Parts-0600-body\_parts.exr.md
-->

\begin{aside}
\label{aside:exercise_31}
\heading{Create executable shell script}


Write a CFEngine policy to ensure '/usr/local/bin/hello.sh' exists, has permissions 0755, owner root, group root, and contents:  
```bash
/bin/echo hello world
```


\end{aside}
\coloredtext{red}{ 400-010-Body\_Parts-0600-body\_parts.exr.md }

<!---
Filename: 400-020-CFEngine\_Grammar-0000-Chapter-Title.md
-->

## Left Hand Side, Right Hand Side

\coloredtext{red}{ 400-020-CFEngine\_Grammar-0000-Chapter-Title.md }

\begin{codelisting}
\codecaption{400-020-CFEngine\_Grammar-0100-Fix\_Your\_Webserver.cf}
```cfengine3, options: "linenos": true
# Example of
#     cfengine_word => builtin_function()

bundle agent main {

  vars:

      "CRLF"
        string => "$(const.r)$(const.n)",
        comment => "HTTP requests are terminated by double CR/LF.
                    Define CRLF variable or else my readtcp()
                    function is too long (goes outside page boundary
                    and gets hard to read).";

      "http_reply"

        handle => "http_client",
        comment => "Demonstrate a function that returns a string. 
                    Run 'GET / HTTP/1.0' and save the output into
                    the 'http_reply' variable.",
        string => readtcp("localhost",
                          "80",
                          "GET / HTTP/1.0$(CRLF)$(CRLF)",
                          "500");
  classes:
      "http_ok"
        handle => "check_http_ok",
        comment => "Check that the Web server is returning HTTP 200 OK",
        expression => regcmp(".*200 OK.*\n.*","$(http_reply)");

      reports: http_ok:: "HTTP OK";
      reports: !http_ok:: "!!! ATTENTION!!!  Fix your web server!!";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{400-020-CFEngine\_Grammar-0110-Z.cf}
```cfengine3, options: "linenos": true
# Example of
#
#     cfengine_word => builtin_function()
#
##  Put this example before the readtcp example


bundle agent main {

  classes:

      "cf_agent_is_present"

        expression => fileexists("/var/cfengine/bin/cf-agent");


  reports:

    cf_agent_is_present::

      "Found: /var/cfengine/bin/cf-agent";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{400-020-CFEngine\_Grammar-0120-List\_Example\_B\_Var\_Slist\_Only.cf}
```cfengine3, options: "linenos": true
# Example of
#
#      cfengine_word => { list }    #  (directly and via variable)

bundle agent main {

  vars:

      "my_slist_0"

        handle => "declare_slist_var",
        comment => "Demonstrate a list on the RHS",
        slist  => {
                    "String contents...",
                    "... are beauutifuuul this time of year"
                  };


      "my_slist_1"

        handle => "declare_another_slist_var",
        comment => "Demonstrate a list variable on the RHS",
        slist  => { @(my_slist_0), "apple", "orange", @(blah) };

}
```
\end{codelisting}

<!---
Filename: 400-020-CFEngine\_Grammar-0130-LHS\_vs\_RHS\_title\_card.md
-->

## LHS/RHS (Continued)

\coloredtext{red}{ 400-020-CFEngine\_Grammar-0130-LHS\_vs\_RHS\_title\_card.md }


<!---
Filename: 400-020-CFEngine\_Grammar-0140-LHS\_vs\_RHS\_Promise\_attributes.md
-->

### Promise attributes

CFEngine uses many "constraint expressions" as part of the body of a promise.  These are attributes of a promise, they detail and constrain the promise.

These take the form:

left-hand-side (cfengine word) => right-hand-side (user defined data).

This can take several forms:

     cfengine_word => user_defined_body or user_defined_body(parameters)

                      builtin_function()

                      "scalar_value" or "$(scalar_variable_name)"

                      { "list_element", "list_element2" }

                      { @(list_variable_name) }

                      boolean

In each of these cases, the right hand side is a user choice. 

\coloredtext{red}{ 400-020-CFEngine\_Grammar-0140-LHS\_vs\_RHS\_Promise\_attributes.md }

\begin{codelisting}
\codecaption{400-020-CFEngine\_Grammar-0150-LHS\_vs\_RHS\_Example\_of\_user\_defined\_body\_on\_rhs.cf}
```cfengine3, options: "linenos": true
SKIP

(this material is dated)

# example of:     cfengine_word => user_defined_body

bundle agent main
{
  storage:

      "/"

        volume  => my_check_volume;

}


body volume my_check_volume
{
        freespace      => "30%";
        # minimum disk space that should be available

        sensible_size  => "100K";
        # Minimum size in bytes that should be used

        sensible_count => "10";
        # Minimum number of files/directories at top level
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{400-020-CFEngine\_Grammar-0160-LHS\_vs\_RHS\_Example\_of\_user\_defined\_body\_on\_rhs\_WITH\_PARAMS.cf}
```cfengine3, options: "linenos": true
# example of:     cfengine_word => user_defined_body(param)

bundle agent main
{
      storage: "/" volume  => my_check_volume("30%", "100K");
      storage: "/var" volume  => my_check_volume("20%", "500K");
}



body volume my_check_volume(min_free_space,size)
{
        freespace      => "$(min_free_space)";
      # Min disk space that should be available

        sensible_size  => "$(size)";
      # Minimum size in bytes that should be used

        sensible_count => "10";
      # Minimum number of files/directories at top level
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{400-020-CFEngine\_Grammar-0170-LHS\_vs\_RHS\_Example\_of\_builtin\_function\_on\_rhs.cf}
```cfengine3, options: "linenos": true
# Example of
#     cfengine_word => builtin_function()

bundle agent main {

  vars:

      "CRLF"
        string => "$(const.r)$(const.n)",
        comment => "HTTP requests are terminated by double CR/LF.
                    Define CRLF variable or else my readtcp()
                    function is too long (goes outside page boundary
                    and gets hard to read).";



      "http_reply"
        handle => "http_client",
        comment => "Demonstrate a function that returns a string.  Run
'GET / HTTP/1.0' and save the output into var http_reply.",
        string => readtcp("localhost",
                          "80",
                          "GET / HTTP/1.0$(CRLF)$(CRLF)",
                          "500");


  reports:

      "The HTTP reply was:$(const.t)$(http_reply)"

        handle => "display_http_reply";

}

# Example output
#
# R: The HTTP reply was:	HTTP/1.1 200 OK
# Date: Mon, 09 Nov 2015 01:52:18 GMT
# Server: Apache/2.2.31 (Unix) DAV/2 mod_ssl/2.2.31 OpenSSL/1.0.2d PHP/5.6.12
# X-Powered-By: PHP/5.6.12
# Set-Cookie: cisession=FbqBuY0X1%2FGxnQQ1O0oOIdZoVlBq0F1tJhY%2Fbr1mAJImtsmcok51qQb6HaYKmHSImCUBxIl9N5slDlHX5nNXC2GNbgAC%2FJVCMKWfIkifx8rp%2FpKbHTn9wNEhyPHUQoab4quOrClP4bHggdW6OzHeMFFlPeOfxgBgYFHS%2FUXhZ3pvjMcMQCXopfl10Te3omy%2Bo9tjboVOFwjjd4EwzStvp591BM3yEtnFa6wtRARwT6h4fQc%2FRtICpdANFKMlbH%2BtQtfQmtn%2FWEJzlgwMOLo8oDgol%2BxyqaBC%2FaovQhDwiwY

```
\end{codelisting}
\begin{codelisting}
\codecaption{400-020-CFEngine\_Grammar-0180-LHS\_vs\_RHS\_Example\_of\_scalar\_on\_rhs.cf}
```cfengine3, options: "linenos": true
# Example of
#      cfengine_word => "quoted scalar"

bundle agent main {

  vars:

      "variable_0"
        handle => "declare_variable_0",
        comment => "RHS is a literal string",
        string  => "String contents...";  # a scalar value

      "variable_1"
        handle => "declare_variable_1",
        comment => "RHS uses a variable",
        string  => "$(variable_0)";       # a scalar variable
  reports:

      "
variable_0: $(variable_0)
variable_1: $(variable_1)
"
        handle => "display_var_values",
        comment => "Display values of both variables";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{400-020-CFEngine\_Grammar-0190-LHS\_vs\_RHS\_Example\_of\_list\_on\_rhs.cf}
```cfengine3, options: "linenos": true
# Example of
#
#      cfengine_word => { list }    #  (directly and via variable)

body common control {

        bundlesequence => { "example_1", "example_2" };

}

bundle agent example_2 {

  reports:



      "Second things second"
        handle => "identify_2nd_bundle",
        comment => "Identify 2nd bundle to demonstrate bundlesequence";
}

bundle agent example_1 {

  reports:



      "First things first"
        handle => "identify_1st_bundle",
        comment => "Identify 1st bundle to demonstrate bundlesequence";
}
```
\end{codelisting}
