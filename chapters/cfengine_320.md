
<!---
Filename: 320-100-Part-Title-0000-Editing\_Files.md
-->

# Editing and Copying Files



<!---
Filename: 320-150-Editing\_Files-0000-Chapter-Title.md
-->

## Editing Files: Line-based


\begin{codelisting}
\codecaption{320-150-Editing\_Files-0330-insert\_lines.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/etc/motd"

        handle  => "files_motd",
        comment  => "Create a nice motd",
        create  => "true",
        edit_line => greet_users;
}

bundle edit_line  greet_users {

  insert_lines:

      "Good morning!"
        handle => "greet_user",
        comment => "Happy users = less complaints. Greet the user
politely.";
}
```
\end{codelisting}

<!---
Filename: 320-150-Editing\_Files-0340-Exercise.exr.md
-->

### Editing /etc/motd

Write a policy that will ensure /etc/motd always contains:

       Unauthorized use forbidden.



<!---
Filename: 320-150-Editing\_Files-0355-syntax\_pattern\_intro.BOOKONLY.md
-->

![Syntax Pattern 1](images/figures/syntax_pattern_intro.pdf)


\begin{codelisting}
\codecaption{320-150-Editing\_Files-0360-delete\_lines.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/etc/motd"

        handle => "motd",
        comment => "Create and populate motd",
        create => "true",
        edit_line => my_motd;
}


bundle edit_line  my_motd {

  insert_lines:

      "Good morning!";

  delete_lines:

      ".*";
}

```
\end{codelisting}

<!---
Filename: 320-150-Editing\_Files-0370-delete\_lines.exr.md
-->

#### delete_lines

Create an /etc/motd file that contains only the 
text "Unauthorized use forbidden"




<!---
Filename: 320-150-Editing\_Files-0380-replace\_patterns\_and\_edit\_field.md
-->

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
```cfengine3, options: "linenos": true
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
```cfengine3, options: "linenos": true
bundle agent main
{
  files:
      "/tmp/test.xml"
        edit_xml => my_xml_example;
}

bundle edit_xml my_xml_example
{

  insert_tree:
      "<Host name=\"a014848585.example.com\">
             <Alias>mail.example.com</Alias>
       </Host>";

}

```
\end{codelisting}
\begin{codelisting}
\codecaption{320-151-Editing\_Files\_XML-0040-edit\_xml.cf}
```cfengine3, options: "linenos": true
bundle agent main
{
  files:
      "/tmp/test.xml"
        edit_xml => set_value;
}

bundle edit_xml set_value
{
  set_text:
      "test.example.com"
        select_xpath => "/Server/Service/Engine/Host/Alias";

}
```
\end{codelisting}

<!---
Filename: 320-151-Editing\_Files\_XML-0090-edit\_xml.exr.md
-->

Do an edit_xml exercise here



<!---
Filename: 320-210-Templates-0000-Chapter-Title.md
-->

## Introduction to Templates



<!---
Filename: 320-210-Templates-0010-intro.md
-->

### Introducing templates

What are templates?  Why would we use templates?

(In class, a brief introductory talk is given for sysadmins that haven't worked with templates.)

In the following templates, we use an uncommon text string (double underscore) to set out our tokens from the rest of the text. This will make it easy to find and replace the tokens with their values (to fill in the template with values) without accidentally replacing actual text.

### Example email template:
```text
Hello __NAME__,

  Please buy our product.

Love,
Company
```

You can expand this template with a shell command:

```bash

$ cat /tmp/letter.template 
Hello __NAME__,

  Please buy our product.

Love,
Company

$ NAME=John
$ sed -e 's:__NAME__:${NAME}:' < letter.template >  letter.txt
$ cat letter.txt 
Hello John,

  Please buy our product.

Love,
Company

$ 

```



<!---
Filename: 320-255-Mustache\_Templates-0000-Chapter-Title.md
-->

## Mustache Templates



<!---
Filename: 320-255-Mustache\_Templates-0000-intro.md
-->

See [Mustache website](http://mustache.github.io/) for documentation of the popular Mustache templating system created by the CTO of GitHub and now available as a library for many languages.


\begin{codelisting}
\codecaption{320-260-0020.mustache}
```text, options: "linenos": true
Uauthorized use forbidded

Property of {{organization}}
{{organizational_unit}}
```
\end{codelisting}

<!---
Filename: 320-260-Mustache\_Templates\_with\_Inline\_Data-0000-Chapter-Title.md
-->

### Mustache Templates: Expanding with an Inline Data Structure



<!---
Filename: 320-265-Mustache\_Templates\_with\_Data\_Container-0000-Chapter-Title.md
-->

### Mustache Templates: Expanding with an External Data Container


\begin{codelisting}
\codecaption{320-265-Mustache\_Templates\_with\_Data\_Container-0010-container.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:
      "/etc/motd"
        create => "true",
        template_method => "mustache",
        edit_template   => "$(this.promise_dirname)/330-060-0020.mustache",
        template_data => parsejson('{
                                        "organization" : "ACME, Inc.",
                                 "organizational_unit" : "Morale Division",
                                     }');
}
```
\end{codelisting}

<!---
Filename: 320-265-Mustache\_Templates\_with\_Data\_Container-exercise.exr.md
-->

#### Render a JSON-backed Mustache template

Make a JSON file

Make a Mustache file

Render the Mustache file using the data inside the JSON file


Example:

JSON file:  { "food" : "pizza" }

Mustache file:  Waiter, I'd like to order {{food}}




\begin{codelisting}
\codecaption{320-270-0015.mustache}
```text, options: "linenos": true
Uauthorized use forbidded

Property of {{vars.g.organization}}

{{#classes.myclass}}
Yes we love UNIX
{{/classes.myclass}}

Have a nice day.
```
\end{codelisting}

<!---
Filename: 320-270-Mustache\_Templates\_with\_Datastate-0000-Chapter-Title.md
-->

### Mustache Templates with Dataspace


\begin{codelisting}
\codecaption{320-270-Mustache\_Templates\_with\_Datastate-0010.cf}
```cfengine3, options: "linenos": true
bundle common g {
      # global settings

  vars:
      "organization"
        string => "Acme Inc.";

  classes:
    "myclass"
       expression => "linux";
}


bundle agent main {

  files:
      "/etc/motd"
        create => "true",
        template_method => "mustache",
        edit_template   => "$(this.promise_dirname)/330-070-0015.mustache";
}
```
\end{codelisting}

<!---
Filename: 320-270-Mustache\_Templates\_with\_Datastate-0030-exercise.exr.md
-->

### Make a mustache template that accesses variables from CFEngine datastate

Example, put the value of the hostname into /etc/motd

```cfengine3
$(sys.fqhost)
```


Example mustache template text:

```text
   The time is: {{vars.sys.date}}
```

### Make a mustache template that accesses classes from CFEngine datastate


```text
{{#classes.linux}}
we love linux {{vars.sys.flavour}}
{{/classes.linux}}
```



<!---
Filename: 320-280-Copying\_Files-0000-Chapter-Title.md
-->

## Copying Files

It is sometimes simpler to copy files wholesale from a master location.

We will show examples of how to do that after we cover the Standard Library (which facilitates file copying).


