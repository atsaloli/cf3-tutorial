
<!---
Filename: 430-000-Part-Title-0000\_Copying\_Files.md
-->

# Copying Files



<!---
Filename: 430-100-File\_Copying-1060-Chapter-Title.md
-->

## File Copying


\begin{codelisting}
\codecaption{430-100-File\_Copying-1070-Local\_copy\_a\_single\_file.cf}
```cfengine3, options: "linenos": true
body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }


########################################


bundle agent main {


  files:

      "/etc/motd"

        copy_from    => local_cp("/var/cfengine/inputs/templates/motd.txt");

}
```
\end{codelisting}

<!---
Filename: 430-100-File\_Copying-1080-exercise.exr.md
-->

* Copy /var/cfengine/share/CoreBase/*cf to /var/cfengine/inputs

* Create /root/passwd.bak as a backup (copy) of /etc/passwd



\begin{codelisting}
\codecaption{430-100-File\_Copying-1090-Local\_copy\_a\_directory.cf}
```cfengine3, options: "linenos": true
body file control { inputs => { "$(sys.libdir)/stdlib.cf" }; }


########################################


bundle agent main
{

  vars:

      # A standard location for the source point
      "master_location" string => "/var/cfengine/masterfiles";

  files:

      "/var/cfengine/inputs/."

        comment      => "Update the policy files from the master",
        copy_from    => local_cp("$(master_location)"),
        depth_search => recurse("inf");

      #   /var/cfengine/masterfiles -----

}
```
\end{codelisting}

<!---
Filename: 430-100-File\_Copying-1100-Exercise.exr.md
-->

### Use CFEngine to make '/tmp/mirror' contain a copy of '/usr/local/sbin'

1.  Use CFEngine to make '/tmp/mirror' contain a copy of '/usr/local/sbin'
(Hint: use a files promise with a copy\_from attribute.)

2. Now create a new file in '/usr/local/sbin' and confirm CFEngine will copy it over.

3. Work out how to mirror file removals.  (When a file is removed in '/usr/local/sbin', it should disappear in '/tmp/mirror'.)


\begin{codelisting}
\codecaption{430-100-File\_Copying-1110-Remote\_copy.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:

      "remote_path" string => "/var/cfengine/masterfiles";
      "remote_server" string => "205.186.156.208";

  files:

      "/var/cfengine/inputs"

        handle => "update_inputs_dir",
        comment => "Pull down latest policy set",
        perms => u_p("600"),
        copy_from => u_remote_cp("$(remote_path)","$(remote_server)"),
        depth_search => u_recurse("inf"),
        action => u_immediate;
}

body perms u_p(p)
{
        mode  => "$(p)";
}

body copy_from u_remote_cp(from,server)
{
        servers     => { "$(server)" };
        source      => "$(from)";
        compare     => "mtime";
        trustkey    => "true";  # trust the server's public key
}

body depth_search u_recurse(d)
{
        depth => "$(d)";
        xdev  => "true";
}

body action u_immediate
{
        ifelapsed => "0";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{430-100-File\_Copying-1120-Remote\_copy\_with\_round\_robin.cf}
```cfengine3, options: "linenos": true
# use two remote servers, and round-robin between them

bundle agent main
{

  classes:
      "heads"
        handle => "flip_a_coin_class",
        comment => "Generate a class with a 50% probability",
        expression => isgreaterthan(randomint(1,100), 50);


  files:
      "/tmp/test1copy"
        copy_from => round_robin_cp("/var/cfengine/masterfiles/testfile1",
                                    "10.1.1.10",
                                    "10.1.1.12");
}


body copy_from round_robin_cp(from,server1, server2)
{
        source => "$(from)";

    heads::
        servers => { "$(server1)", "$(server2)" };

    !heads::
        servers => { "$(server2)", "$(server1)" };

}
```
\end{codelisting}

<!---
Filename: 430-100-File\_Copying-1130-Notes\_for\_setting\_up\_client\_server.md
-->

!! SKIP !! 


