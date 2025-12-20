
<!---
Filename: 320-100-Part-Title-0000-Editing\_Files.md
-->

# Editing Files



<!---
Filename: 320-150-Editing\_Files-0000-Chapter-Title.md
-->

## Editing Files: Line-based



\begin{codelisting}
\codecaption{320-150-Editing\_Files-0010-insert\_lines.cf}
```cfengine3, options: "linenos": false
# Create a file and populate its content

bundle agent main
{
  files:
      "/etc/motd"
        create  => "true",
        edit_line => greet_users;
}

bundle edit_line greet_users
{
  insert_lines:
      "Good morning!";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{320-150-Editing\_Files-0015-insert\_lines\_parameterized.cf}
```cfengine3, options: "linenos": false
# You can parameterize bundles -- let's try that with
# the edit_line bundle

bundle agent main
{
  files:
      "/etc/motd"
        create  => "true",
        edit_line => say_something("Good morning");
}

bundle edit_line say_something(what_we_say)
{
  insert_lines:
      "$(what_we_say)";
}
```
\end{codelisting}
<!---                 
Filename: 320-150-Editing\_Files-0020-Exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_24}
\heading{Editing /etc/motd}


Write a policy that will ensure /etc/motd always has the line:

Unauthorized use forbidden.


\end{aside}
\begin{codelisting}
\codecaption{320-150-Editing\_Files-0025-insert\_lines\_good\_afternoon.cf}
```cfengine3, options: "linenos": false
# Change "good morning" to "good afternoon".
# What will the file contain after we run cf-agent?

bundle agent main
{
  files:
      "/etc/motd"
        create  => "true",
        edit_line => greet_users;
}

bundle edit_line greet_users
{
  insert_lines:
      "Good afternoon!";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{320-150-Editing\_Files-0030-delete\_lines.cf}
```cfengine3, options: "linenos": false
# You can control the entire file content by adding
# the edit_line promise `delete_lines: "*";`

bundle agent main
{
  files:
      "/etc/motd"
        create => "true",
        edit_line => my_motd;
}

bundle edit_line my_motd
{
  insert_lines:
      "Good afternoon!";

  delete_lines:
      ".*";
}

# Why doesn't this just leave the file empty?

```
\end{codelisting}
<!---                 
Filename: 320-150-Editing\_Files-0040-delete\_lines.exr.md
-->

\begin{aside}
\label{aside:exercise_25}
\heading{Making "delete\_lines" promises}


Write a policy to ensure the /etc/motd file (a) exists, and (b) contains
_only_ the line  "Unauthorized use forbidden".



\end{aside}
\begin{codelisting}
\codecaption{320-150-Editing\_Files-0060-insert\_type\_file.cf}
```cfengine3, options: "linenos": false
# You can insert a file using the `insert_type`
# attribute of `insert_lines` promises.

bundle agent main
{
  files:
      "/tmp/test.txt"
        create => "true",
        edit_line => mytext;
}

bundle edit_line mytext
{
  insert_lines:
      "Here are our OS details";
      "/etc/os-release"
        insert_type => "file";
}
```
\end{codelisting}

<!---
Filename: 320-150-Editing\_Files-0070-replace\_patterns\_and\_edit\_field.md
-->

### More edit_line promise types

There are two other promise types you can make in edit\_line bundles:

**replace\_patterns**
: search and replace

**edit\_field**
: columnar editing

We will look at them later.



<!---
Filename: 320-151-Editing\_Files\_XML-0000-Chapter-Title.md
-->

## Editing Files: XML


\begin{codelisting}
\codecaption{320-151-Editing\_Files\_XML-0010-edit\_xml.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  files:
      "/tmp/test.xml"
        comment => "Create XML file",
        create => "true",
        edit_xml => build_xpath;
}

bundle edit_xml build_xpath
{
   build_xpath:
      "/Server/Service/Engine";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{320-151-Editing\_Files\_XML-0030-edit\_xml.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  files:
      "/tmp/test.xml"
        edit_xml => my_xml_example;
}

bundle edit_xml my_xml_example
{
  insert_tree:
      '<Host name="a014848585.example.com">
             <Alias>mail.example.com</Alias>
       </Host>'
        select_xpath => "/Server/Service/Engine";
}

```
\end{codelisting}
\begin{codelisting}
\codecaption{320-151-Editing\_Files\_XML-0040-edit\_xml.cf}
```cfengine3, options: "linenos": false
bundle agent main
{
  files:
      "/tmp/test.xml"
        edit_xml => set_value;
}

bundle edit_xml set_value
{
  set_text:
      "nancy.example.com"
        select_xpath => "/Server/Service/Engine/Host/Alias";

}
```
\end{codelisting}
<!---                 
Filename: 320-151-Editing\_Files\_XML-0090-edit\_xml.exr.md
-->

\begin{aside}
\label{aside:exercise_26}
\heading{Editing an XML config file}


Use CFEngine's XML editing features to create an XML file with the following structure and content:

```xml
<?xml version="1.0"?>
<book><title>Learning CFEngine 3</title><author>Diego Zamboni</author></book>
```


\end{aside}
