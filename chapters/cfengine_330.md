
<!---
Filename: 330-100-Part-Title-0000-File\_Templates.md
-->

# Templating Files



<!---
Filename: 330-210-Templates-0000-Chapter-Title.md
-->

## Introduction to Templates



<!---
Filename: 330-210-Templates-0010-intro.md
-->

### Introducing templates

What are templates?  Why would we use templates?

(In class, a brief introductory talk is given for sysadmins that haven't
worked with templates.)

In the following templates, we use an uncommon text string (double
underscore) to set out our tokens from the rest of the text. This will
make it easy to find and replace the tokens with their values (to fill
in the template with values) without accidentally replacing actual text.




<!---
Filename: 330-210-Templates-0020-example\_template.md
-->

### Example Template

Here is an example template, for a promotional email message:

```text
Hello __NAME__,

  Please buy our product.

Love,
Company
```

Notice the `__NAME` as the placeholder for the person's name.



<!---
Filename: 330-210-Templates-0030-example\_template\_2.md
-->

### Expanding the Template

You "expand" the template by populating it with data:

```console
$ cat /tmp/letter.template
Hello __NAME__,

  Please buy our product.

Love,
Company

$ NAME=John
$ sed -e "s:__NAME__:${NAME}:" < letter.template >  letter.txt
$ cat letter.txt
Hello John,

  Please buy our product.

Love,
Company

$
```



<!---
Filename: 330-255-Mustache\_Templates-0000-Chapter-Title.md
-->

## Mustache Templates



<!---
Filename: 330-255-Mustache\_Templates-0000-intro.md
-->

See [Mustache website](http://mustache.github.io/) for documentation of
the popular Mustache templating system created by the CTO of GitHub and
now available as a library for many languages.



<!---
Filename: 330-260-Mustache\_Templates\_with\_Inline\_Data-0000-Chapter-Title.md
-->

### With an Inline Data Container


\begin{codelisting}
\codecaption{330-260-Mustache\_Templates\_with\_Inline\_Data-0020-motd\_template.mustache}
```text, options: "linenos": false
                 Unauthorized use forbidden

              Property of {{organization}}
                   {{organizational_unit}}
```
\end{codelisting}
\begin{codelisting}
\codecaption{330-260-Mustache\_Templates\_with\_Inline\_Data-0030-inline\_template\_data.cf}
```cfengine3, options: "linenos": false
# Inline template data

bundle agent main
{
  files:
      "/etc/motd"
        create => "true",
        template_method => "mustache",
        edit_template   => "$(this.promise_dirname)/templates/motd.mustache",
        template_data => '{
                                        "organization" : "ACME, Inc.",
                                 "organizational_unit" : "Roadrunner Division",
                          }';
}
```
\end{codelisting}

<!---
Filename: 330-265-Mustache\_Templates\_with\_Data\_Container-0000-Chapter-Title.md
-->

### With an External Data Container


\begin{codelisting}
\codecaption{330-265-Mustache\_Templates\_with\_Data\_Container-0010-container.cf}
```cfengine3, options: "linenos": false
# Template data from standalone data container

bundle agent main
{
  vars:
      "my_template_data"
        data => '{
                   "organization" : "ACME, Inc.",
                   "organizational_unit" : "Roadrunner Division",
                 }';

  files:
      "/etc/motd"
        create => "true",
        template_method => "mustache",
        edit_template   => "$(this.promise_dirname)/templates/motd.mustache",
        template_data => @(my_template_data);
}
```
\end{codelisting}
<!---                 
Filename: 330-265-Mustache\_Templates\_with\_Data\_Container-0020-exercis.exr.md
-->

\begin{aside}
\label{aside:exercise_27}
\heading{Render a JSON-backed Mustache template}


1. Make a JSON file:

```bash
echo '{ "food" : "pizza" }' > food.json
```

2. Make a Mustache template:

```bash
echo "Waiter, I'd like to order {{food}}" > order.mustache
```

3. Write CFEngine policy that will render the Mustache 
   template using the data in the JSON file.

Hint: see the `readjson()` function in the reference manual.




\end{aside}

<!---
Filename: 330-270-Mustache\_Templates\_with\_Datastate-0000-Chapter-Title.md
-->

### With Datastate

Function `datastate()` returns a data container with the current evaluation data state (all the classes and variables in cf-agent memory).

The returned data container will have the keys `classes` and `vars`.

Under `classes` you'll find a map with the class name as the key and `true` as the value.

Under `vars` you'll find a map with the bundle name as the key. Under the bundle name you'll find another map with the variable name as the key.


Definition:

**dictionary** (also known as map)
: An abstract data type storing items, or values. A value is accessed by an associated key.  
https://xlinux.nist.gov/dads/HTML/dictionary.html


\begin{codelisting}
\codecaption{330-270-Mustache\_Templates\_with\_Datastate-0005-datastate.cf}
```cfengine3, options: "linenos": false
# Show datastate
#
# This policy will dump the first 4k of the datastate
# (4096 bytes due to internal limits in CFEngine)
#
# Note: the datastate report will show a copy of the
# datastate in vars.main.datastate (vars.main.datastate.vars
# and vars.main.datastate.classes)

bundle agent main
{
  vars:
    "datastate"
      data => datastate();

    "formatted_datastate"
      string => storejson("datastate");

  reports:
    "Datastate =
$(formatted_datastate)
";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{330-270-Mustache\_Templates\_with\_Datastate-0010-inline\_data.cf}
```cfengine3, options: "linenos": false
bundle common g
# global settings
{
  vars:
      "organization"
        string => "Acme Inc.";

  classes:
    "snow_day"
       expression => "any",
       comment => "set a class so we can then pull it out, for the demo";
}

bundle agent main
{
  vars:
      "foo"
        string => "bar";

  files:
      "/etc/motd"
        create => "true",
        template_method => "mustache",
        edit_template   => "$(this.promise_dirname)/templates/datastate-example.mustache";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{330-270-Mustache\_Templates\_with\_Datastate-0015-template.mustache}
```text, options: "linenos": false
Unauthorized use forbidden

Property of {{vars.g.organization}}

{{#classes.snow_day}}
The office is closed today.
{{/classes.snow_day}}

{{#classes.dev}}
DEVELOPMENT
{{/classes.dev}}

{{#classes.ops}}
OPS ROCKS
{{/classes.ops}}

This system is managed by CFEngine
my hostname is {{vars.sys.fqhost}}

The value of foo is {{vars.main.foo}}

Have a nice day.
```
\end{codelisting}
<!---                 
Filename: 330-270-Mustache\_Templates\_with\_Datastate-0030-exercise.exr.md
-->

\begin{aside}
\label{aside:exercise_28}
\heading{Make a Mustache template that accesses CFEngine datastate}


Create /etc/motd from a Mustache template that includes the host name,
time of last run, and time of last policy update.

E.g.:

```bash
$ cat /etc/motd
*** Unauthorized Use Forbidden ***

Welcome to apple.example.com

This system is managed by CFEngine.
Last CFEngine policy update: Thu Nov  5 19:22:02 GMT 2015
Last CFEngine run: Thu Nov  5 19:22:03 GMT 2015
$
```

Then, make a mustache template that accesses classes from CFEngine datastate

Make /etc/motd say "Welcome to a Linux system" if the CFEngine linux "class" is set.




\end{aside}

<!---
Filename: 330-270-Mustache\_Templates\_with\_Datastate-0080-would\_you\_like\_to\_know\_more.md
-->

#### Would you like to know more?

Reference: <https://docs.cfengine.com/docs/3.12/guide-faq-mustache-templating.html>


