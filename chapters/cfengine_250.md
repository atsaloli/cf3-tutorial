
<!---
Filename: 250-000-Part-Title-0000-Basic\_Promises.md
-->

# Basic Promises



<!---
Filename: 250-010-Files-0000-Chapter-Title.md
-->

## Files


\begin{codelisting}
\codecaption{250-010-Files-0210-Create\_a\_file.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/tmp/nologin2"

        handle => "touch_etc_nologin",
        comment => "Quiesce the system for maintenance",
        create  => "true";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-010-Files-0220-Touch\_a\_file.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/var/cfengine/i_am_alive"

        comment => "Update heartbeat timestamp (mtime)
                          to confirm CFEngine is running",
        create  => "true",
        touch   => "true";
}
```
\end{codelisting}

<!---
Filename: 250-010-Files-0230-Exercise.exr.md
-->

### Create a file

Write and run a policy promising that /etc/ftp.deny is present




<!---
Filename: 250-020-Processes-0000-Chapter-Title.md
-->

## Processes


\begin{codelisting}
\codecaption{250-020-Processes-0010-Stopping\_A\_Process\_Gracefully.cf}
```cfengine3, options: "linenos": true
# Shut down print services.
# To set up for this demo, run:
# yum install cups
# /etc/init.d/cups start

bundle agent main {

  processes:

      "cupsd"

        handle => "shutdown_print_services",
        comment => "Shutdown print services on machines
that are not print servers",
        process_stop => "/etc/init.d/cups stop";

}
```
\end{codelisting}

<!---
Filename: 250-020-Processes-0255-Definition\_scalar.md
-->

### Note on Syntax: Single Values vs Lists

Definitions

scalar
: (programming) Any data type that stores a single value (e.g. a number or Boolean), as opposed to an aggregate data type that has many elements. A string is regarded as a scalar in some languages (e.g. Perl)  --- Free On-Line Dictionary of Computing

In CFEngine syntax, scalar values are enclosed in double quotes:

```cfengine3
process_stop => "/etc/init.d/cups stop",
```



<!---
Filename: 250-020-Processes-0257-Definition\_list.md
-->

list
: A data structure holding many values --- Free On-Line Dictionary of Computing

In CFEngine syntax, lists are in curly braces and 
are a collection of comma-separated scalar values:

```cfengine3
processes:
    "cupsd"
        signals #> { "TERM", "KILL" };
```


\begin{codelisting}
\codecaption{250-020-Processes-0260-Terminating\_a\_process.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  processes:

      "eggdrop"

        handle => "kill_IRC_bots",
        comment => "We don't want IRC bots on our Web servers",
        signals => { "TERM", "KILL" };

}
```
\end{codelisting}

<!---
Filename: 250-020-Processes-0270-Exercise.exr.md
-->

### Kill a process

Start print services:

  yum install cups
  /etc/init.d/cups start

Write and run a promise to signal TERM and KILL to the cupsd process


WARNING: add example here

 processes:

    "^root\s+\d+\s+\d+\s+\d+\s+[89][0-9]\..*splunkd"

      comment => "Restart splunk if it's using more than 80% of the CPU.
                  A restart seems to
                  clear it up.",
      process_stop => "/opt/splunkforwarder/bin/splunk restart";

Add ps command line and how to find it.





<!---
Filename: 250-030-Commands-0000-Chapter-Title.md
-->

## Commands


\begin{codelisting}
\codecaption{250-030-Commands-0290-date.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  commands:

      "/bin/date";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-030-Commands-0300-echo\_hello\_world.cf}
```cfengine3, options: "linenos": true
bundle agent main
{

  commands:

      "/bin/echo"

        comment => "Demonstrate a command with arguments",
        args => "Hello world!";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-030-Commands-0310-Relative\_path\_does\_not\_work.cf}
```cfengine3, options: "linenos": true
bundle agent main
{

  commands:

      "echo"
        args => "Hello world";

}

```
\end{codelisting}
\begin{codelisting}
\codecaption{250-030-Commands-0320-Dig\_a\_deep\_hole.sh}
```bash, options: "linenos": true
#!/bin/sh

# demonstrate handling of multi-line output

# Create an executable with a long path name - we'll need
# it for the next example

LONG_PATH=/usr/local/sbin/a/really/long/path/to
/bin/mkdir  -p ${LONG_PATH}
/bin/cp -p /usr/bin/printf ${LONG_PATH}/printf >/dev/null
ls -l /usr/bin/printf ${LONG_PATH}/printf
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-030-Commands-0330-Quoted\_multiline\_output.cf}
```cfengine3, options: "linenos": true
# demonstrate handling of multi-line output

bundle agent main
{

  commands:
      "/usr/local/sbin/a/really/long/path/to/printf"
        args => "Line 1\nLine 2\nLine 3",
        comment => "Demonstrate how CFEngine truncates
                    path names in command output";
}
```
\end{codelisting}

<!---
Filename: 250-030-Commands-0340-command.exr.md
-->

yum install mlocate

Write and run a promise to run the "updatedb" command to update the "locate" database.



<!---
Filename: 250-032-Reports-0000-Chapter-Title.md
-->

## Reports


\begin{codelisting}
\codecaption{250-032-Reports-0010-hello\_world.cf}
```cfengine3, options: "linenos": true
bundle agent main
{
  reports:

      "Hello world!";
}
```
\end{codelisting}

<!---
Filename: 250-101-Scalars-0000-Chapter-Title.md
-->

## Variables

CFEngine variables can contain single values or collections of single values (lists, arrays and JSON containers).



<!---
Filename: 250-101-Scalars-0005-scalars.md
-->

### Scalars



<!---
Filename: 250-101-Scalars-0010-intro.md
-->

Scalars

* A scalar is a single value.

* Each scalar may have one of three types: string, int or real.



<!---
Filename: 250-101-Scalars-0015-naming\_scalar\_vars.md
-->

### Identifying scalar variables

A scalar variable is represented as

```cfengine3
$(identifier)
```

or

```cfengine3
${identifier}
```

Round braces are Make-style; curly braces are UNIX shell style.

Example:
```cfengine3
reports:
  "Hello, $(name)";
```

Braces help the parser know for sure when a variable name ends so it doesn't have to guess if the variable name is embedded in text: 

```cfengine3
reports:
  "The product number is: $(machine_type)$(model)";
```


\begin{codelisting}
\codecaption{250-101-Scalars-0018-scalar.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:

      "name"
        string => "Inigo Montoya";

      "greeting"
        string  => "Hello. My name is $(name). ";

  reports:

      "$(greeting)";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-101-Scalars-0020-Examples\_of\_scalar\_variables.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:

      "my_string"      string  => "String contents...";

      "my_int" int => "42";

      "my_real" real    => "3.141592654";

      "my_second_string"
        string =>  "I love: $(my_string)";

  reports:

      "My string is: $(my_string)
My integer is: $(my_int)
My real number is: $(my_real)
$(my_second_string)";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-101-Scalars-0170-typing.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:

      "my_int"

        comment => "Try to assign a real number to an integer
                          variable to see how CFEngine handles
                          data typing.",
        int => "1.5";

  reports:

      "My value is $(my_int).";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-101-Scalars-0180-typing\_2.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:

      "my_int"

        comment => "Try to assign a string to an integer variable.",
        int => "hello world";


  reports:

      "my int is $(my_int)";

}
```
\end{codelisting}

<!---
Filename: 250-101-Scalars-0190-vars.exr.md
-->

### Make and use a variable

Write a policy to set a variable called "first_name" and set the value to your first name.

Then create a reports promise to have CFEngine say hello using this variable.




<!---
Filename: 250-101-Scalars-0200-variable\_scope.md
-->

### Scope of variables

Note: a fully qualified variable consists of the bundle name wherein the variable is defined plus the variable name. 

```cfengine3
bundle agent mybundle {
  vars:
      "myvar"
        string => "myvalue";
}
```

Unqualified: $(myvar) 

Qualified: $(mybundle.myvar) 



\begin{codelisting}
\codecaption{250-101-Scalars-0410-Demo\_of\_variable\_scope.cf}
```cfengine3, options: "linenos": true
bundle agent bundle_1 {

  vars:
      "var_1"
        string  =>  "Hello World";
}

bundle agent bundle_2 {

  vars:
      "var_1"
        string => "My fair lady";

  reports:
      #"Variable value = $(bundle_1.var_1)";
      #"Variable value = $(bundle_2.var_1)";
      "Variable value = $(var_1)";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-101-Scalars-0411-variable\_scope\_2.cf}
```cfengine3, options: "linenos": true
# Simplify / break in parts

bundle agent bundle_0 {
      vars: "fruit" string => "banana";
      reports: "This is bundle_0";
}

bundle agent bundle_1 {
      vars: "fruit" string => "apple";
  reports:
      "Bundle 1: bundle_0.fruit = '$(bundle_0.fruit)'";
}

bundle agent bundle_2 {
  reports:
      "Bundle 2: bundle_1.fruit = '$(bundle_1.fruit)'";
}

bundle agent bundle_4 { vars: "xyzzy" string => "magic"; }
```
\end{codelisting}

<!---
Filename: 250-101-Scalars-0420-variable\_scope.exr.md
-->

Declare a variable in one bundle and then use it from another bundle.  Use the cf-agent -b switch to specify bundle sequence.

```bash
cf-agent -f <filepath> -b <bundlesequence>
```



<!---
Filename: 250-110-Integer\_Constants-0000-Chapter-Title.md
-->

##### Integer Constants



<!---
Filename: 250-110-Integer\_Constants-0220-Special\_suffixes\_for\_Integer\_constants.md
-->

### Integer Suffixes

Integer values may use suffixes to represent large numbers.

Which is easier to read?

* 200000
* 200k



<!---
Filename: 250-110-Integer\_Constants-0230-Special\_suffixes\_for\_Integer\_constants\_refcard.md
-->

### Integer Suffixes

*k*
: value times 1000.

*m*
: value times 1000^2

*g*
: value times 1000^3

*K*
: value times 1024.

*M*
: value times 1024^2

*G*
: value times 1024^3

*%*
: meaning percent, in limited contexts

*inf*
: a constant representing an unlimited value.


\begin{codelisting}
\codecaption{250-110-Integer\_Constants-0240-Integer\_suffixes\_demo.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:

      "fourty_two_kilobytes"             int     => "42k";  # 42 x 1000
      "fourty_two_kibibytes"             int     => "42K";  # 42 x 1024
      "infinity"                         int     => "inf";  # infinity


  reports:

      "42 x 1000 = $(fourty_two_kilobytes)";
      "42 x 1024 = $(fourty_two_kibibytes)";
      "infinity = $(infinity)";
}
```
\end{codelisting}

<!---
Filename: 250-120-Lists-0000-Chapter-Title.md
-->

### Lists



<!---
Filename: 250-120-Lists-0250-List\_variables.md
-->

A list is a collection of scalars (single values).

A list variable is represented as @(identifier) or @(bundlename.identifier)

If you refer to a list variable in scalar context by using $(identifier), cfengine will implicitly loop over the values of @(list).


\begin{codelisting}
\codecaption{250-120-Lists-0260-List\_variables\_and\_implicit\_looping.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:

      "shopping_list"

        slist   => {
                     "apples",
                     "bananas",
                     "grapes",
                     "plantains",
                     "coconuts",
        };

  reports:

      "buy $(shopping_list)";
}

```
\end{codelisting}
\begin{codelisting}
\codecaption{250-120-Lists-0280-List\_variables\_Concatenation\_of\_slists.cf}
```cfengine3, options: "linenos": true
bundle agent main0 {

  vars:

      "my_slist"
        slist => { "String contents...", "...are great!" };

  reports:

      " Iterating over list 'my_slist':";
      "$(my_slist)"
        comment => "Demonstrate how list variables are handled";

}





bundle agent main {

  vars:
      "preface"
        string => "Now hear this: ";

      "my_slist"
        slist => { "String contents...", "...are great!" };

      "the_sum_of_all_parts"
        slist => { $(preface), @(my_slist) };

  reports:

      " Iterating over list 'the_sum_of_all_parts': $(the_sum_of_all_parts)"
        comment => "Demonstrate how list variables are handled";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-120-Lists-0290-Lists\_of\_integers.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:

      "my_list"

        handle => "int_list",
        comment => "Demonstrate a list of integers",
        ilist => { "1", "2", "3" };
  reports:



      "Iterating over the values in @(my_list):  $(my_list)"
        handle => "demo_int_list",
        comment => "Demonstrate implicit looping over an ilist";
}

```
\end{codelisting}
\begin{codelisting}
\codecaption{250-120-Lists-0300-Lists\_of\_real\_numbers.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:

      "my_list"

        handle => "rlist_demo",
        comment => "Create an rlist",
        rlist => { "1.5", "3.0", "4.5" };


  reports:



      "Iterating over the values in @(my_list):  $(my_list)"
        handle => "display_rlist",
        comment => "Demonstrate looping over an rlist";
}
```
\end{codelisting}

<!---
Filename: 250-120-Lists-0310-exercise.exr.md
-->

Create a list variable containing names of five files to create.  For example:

      /tmp/file1
      /tmp/file2
      /tmp/file3
      /tmp/file4
      /tmp/file5

   Then use a single "files" promise to ensure all five files exist.
   



<!---
Filename: 250-120-Lists-0320-exercise.exr.md
-->

Create a list containing names of processes that should not be running: for example "trn" and "eggdrop"

   Use a single "processes" promise to ensure these processes are not running.

If you finish before the rest of the class, please study your red CFEngine book.




<!---
Filename: 250-130-Data\_Structures\_Arrays-0000-Chapter-Title.md
-->

### Arrays



<!---
Filename: 250-130-Data\_Structures\_Arrays-0340-Arrays\_arrays.md
-->

Arrays are associative (hashes). 

They may contain scalars or lists as their elements.

Array variables are written with '[' and ']' brackets:

```cfengine3
$(array_name[key_name])
```

or

```cfengine3
$(bundle_name.array_name[key_name])
```

Example: 

Food Prices
| Apple | 59c |
| Banana | 30c |
| Oranges | 35c |

Variable assignment:

```cfengine3
vars:   "food_prices[Apple]"    string =>  "59c";
```
  
Now we can use this variable:
```cfengine3
$(food_prices[Apple])
```


\begin{codelisting}
\codecaption{250-130-Data\_Structures\_Arrays-0349-array\_simple\_example.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:

      "food_prices[Apple]"
        string =>  "59c";

      "food_prices[Banana]"
        string =>  "30c";

      "food_prices[numlist]"
        ilist => { "1", "2", "3" };


  reports:
      "Apple costs $(food_prices[Apple])";
      "Banana costs $(food_prices[Banana])";
      "Numlist: $(food_prices[numlist])";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{250-130-Data\_Structures\_Arrays-0350-Arrays\_Array\_of\_strings.cf}
```cfengine3, options: "linenos": true
bundle agent main {
  vars:
      "cfengine_components[cf-monitord]"
        string => "The monitor";

      "cfengine_components[cf-serverd]"
        string => "The server";

      "cfengine_components[cf-execd]"
        string => "The executor";

      "component_names"
        comment => "Extract keys from cfengine_components array",
        slist => getindices("cfengine_components");

  reports:
    "Key = '$(component_names)'";
    "Value = $(cfengine_components[$(component_names)])";
    "cf-monitord is $(cfengine_components[cf-monitord])";
    "$(component_names) = $(cfengine_components[$(component_names)])";



}

```
\end{codelisting}

<!---
Filename: 250-130-Data\_Structures\_Arrays-0355-array.exr.md
-->

### Print array contents using getindices()

Print contents of the array from your last exercise
by using the getindices() function to get a list of
keys, and then iterate over the keys to extract the
values.


\begin{codelisting}
\codecaption{250-130-Data\_Structures\_Arrays-0360-Arrays\_Keys\_are\_case\_senSiTiVE.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:

      "cfengine_components[cf-execd]"
        handle => "describe_executor",
        comment => "Document the cf-execd component",
        string => "The executor";

  reports:

      "$(cfengine_components[CF-exEcD])"
        handle => "case_demo",
        comment => "Case maTTerS!";

}

```
\end{codelisting}

<!---
Filename: 250-130-Data\_Structures\_Arrays-0370-Arrays\_Example.md
-->

See 220-1850_Security.__Configure_sshd,_stub.cf



<!---
Filename: 250-130-Data\_Structures\_Arrays-0380-Arrays.exr.md
-->

Make an array, student_grades.

Populate it with the following data:


|   Key |    Value |
| Joe | A |
| Mary | A |
| Bob | B |
| Sue | B |

Display the contents of the array.


\begin{codelisting}
\codecaption{250-130-Data\_Structures\_Arrays-0390-Arrays\_Array\_of\_slists.cf}
```cfengine3, options: "linenos": true
bundle agent main {
      # implicit looping over slist in array

  vars:
      "config[users]"
        handle => "users_list_in_config_array",
        comment => "Demonstrate how an array value can hold a list",
        slist => { "jim", "jane", "george" };

      "config[packages]"
        handle => "packages_list_in_config_array",
        comment => "Demonstrate how an array value can hold a list",
        slist => { "httpd", "php" };

      #######################################################################

      "keys"
        handle => "config_array_keys",
        comment => "generate a list containing keys to 'config' array",
        slist => getindices("config");


  reports:


      "The value for key $(keys) is: $(config[$(keys)])";

}
```
\end{codelisting}

<!---
Filename: 250-150-Data\_Structures\_Containers-0000-Chapter-Title.md
-->

### Data Containers


\begin{codelisting}
\codecaption{250-150-Data\_Structures\_Containers-0010-readjson.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:
      "mydata"
        data => parsejson('{"Pizza" : "Pepperoni"} ');

      "keys"
        slist => getindices("mydata");

  reports:

      "$(keys)  $(mydata[$(keys)])";
}
```
\end{codelisting}

<!---
Filename: 250-150-Data\_Structures\_Containers-0011-readjson.exr.md
-->

### Data containers - readjson

1. Turn your array from the previous exercises into
   a JSON data file, example.json

{
  "iPhone" : "500$",
  "Samsung" : "450$",
}

2. Read it in a "data" type variable using readjson()
   function

  vars:

      "mydata"
        data => readjson("/path/to/example.json", 100k);

3. Report its contents   
   - get the keys using getindices()
   - iterate over the keys to report the values
  vars:
      "keys"
        slist => getindices("mydata");
  reports:
      "$(keys)  $(mydata[$(keys)])";



<!---
Filename: 250-210-Methods-0000-Chapter-Title.md
-->

## Methods

These are promises to take on a whole other bundle of promises.


\begin{codelisting}
\codecaption{250-210-Methods-0010-simple\_example.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  vars:

      "userlist" slist => { "alex", "ben", "charlie", "diana", "rob" };

  methods:

      "Remove Users"

        usebundle => remove_user("$(userlist)");

}

###########################################

bundle agent remove_user(user) {

  commands:

      "/usr/sbin/userdel $(user)";
      "/bin/rm /var/spool/cron/$(user)";
      "/bin/rm /var/mail/$(user)";
}
```
\end{codelisting}

<!---
Filename: 250-210-Methods-0011-methods.exr.md
-->

#### Exercise

1. create two bundles that each reports its name
2. have bundle #1 call bundle #2


