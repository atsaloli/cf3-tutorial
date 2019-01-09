
<!---
Filename: 955-000-Part-Title-0000-Vocab\_Primer.md
-->

# Appendix A - CFEngine Vocabulary Primer	

Based on the works of Mark Burgess and CFEngine AS. 

## Preface
CFEngine is designed to be comprehensive and to let you model
nearly any aspect of system configuration using promises
(statements of intention).

There are over 500 promise attributes in CFEngine 3.
They enable you to detail the desired system state.

This document presents a "starting set" of commonly
used ones. We suggest you learn them first.

For more detail on the below, use the "Search CFEngine docs"
[search box](http://cf-learn.info/) (on the bottom right),
or see the [CFEngine docs](https://cfengine.com/docs/)

For professional CFEngine training, visit [Vertical Sysadmin](http://www.verticalsysadmin.com)

## Promise Types

Arranged in the order CFEngine checks them (see "Normal Ordering" in the Reference Manual): 

| vars    | A promise to be a variable, representing a value.
| classes | A promise to be a boolean variable representing true/on/1.
| files   | A promise about a file, including its existence, attributes and contents.
| delete\_lines   | A promise about file contents (that specified content is absent).
| field\_edits   | A promise about file contents (concerning values in text fields)
| insert\_lines   | A promise about file contents (that specified content is present).
| replace\_patterns   | A promise about file contents (that specified content is absent, replaced by another).
| packages | A promise concerning a package, including its presence (or absence) and version.
| processes | A promise concerning items in the system process table.
| services | A promise concerning the state (on/off) of a service (a group of one or more processes that runs in the background).
| commands | A promise to execute a command.
| reports | A promise to report a message.


## Promise Attributes 


What follows is a listing of promise attributes by promise type.

### Any


These promise attributes can be used in *any* promise.

| comment | A comment about this promise's intention that follows through the program
| depends\_on | A list of promise handles that this promise depends on somehow.
| handle | A unique id-tag string for referring to this as a promisee elsewhere


### classes


| expression | Evaluate string expression of classes
| and        | Combine class sources with AND - useful for including functions
| or         | Combine class sources with inclusive OR - useful for including functions


### reports


| report\_to\_file | The path and filename to which output should be appended

### vars

| string | A string
| int | An integer
| real | A real number (an integer with a fractional component)
| slist | A list of strings
| ilist | A list of integers
| rlist | A list of real numbers


### commands

| args | String of arguments for the command



### files

| copy\_from | (external body) Used to copy files - see Standard Library section.
| create | true/false whether to create non-existing file
| edit\_line | Specifies name of edit\_line bundle
| edit\_template | The name of a special CFEngine template file to expand
| perms | (external body) Used to set file attributes like permissions, ownership, etc.  See Standard Library section.
| touch | true/false whether to touch time stamps on file
| transformer | Command (with full path) used to transform current file (no shell wrapper used)



### packages

| package\_architectures | Select architecture for package selection
| package\_policy | Criteria for package installation/upgrade on the current system (e.g. "add", "delete")

### processes

| process\_stop | A command used to stop a running process gracefully
| restart\_class | A class to be defined globally if the process is not running, so that a commands: rule can be referred to restart the process
| signals | Signals to be sent to a process

### services


| service\_policy | Policy for service (start/stop)


### Attributes in CFEngine Standard Library

| Type | Attribute | Value | Description
| * | action | immediate | Do it, do it nowww!
| * | action | log\_repaired | Log a repair
| * | classes | if\_repaired | Set class(es) if a promise was repaired
| files | replace\_with | value | Search and replace
| files | copy\_from | local\_cp | Copy files locally
| files | copy\_from | remote\_cp | Copy files from remote server
| files | changes | detect\_all\_change | File integrity check
| files | delete | tidy | Delete files, including symlinks to directories and empty directories.
| files | perms | mog | Set mode, owner, group attributes on a file
| files | edit\_line | insert\_lines | Make sure file contains lines
| files | edit\_line | expand\_template | Make sure file contains content expanded from a template
| files | edit\_line | set\_config\_values | Set config values in a file
| files | depth\_search | depth | Maximum depth level for search (use with depth("inf") to turn on unbounded recursion)
| files | file\_select | days\_old(days) | Select files by age 
| files | file\_select | name\_age(name,days) | Select files by name and age 
| files | location | before | Insert text before specified location
| files | location | after | Insert text after specified location
| packages | package\_method | yum | Interface with YUM package manager
| packages | package\_method | apt | Interface with APT package manager
| commands | contain | useshell | Run the command in a shell to use I/O redirection or pipelining


## Functions

| fileexists() | Returns "true" if the named file can be accessed 
| classmatch()  | Returns "true" if the regular expression matches any currently defined class


## Special Variables

| $(sys.date) | Current time and date
| $(sys.host) | Hostname
| $(sys.policy\_hub) | Address of our policy server.


