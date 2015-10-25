
<!---
Filename: 510-000-Part-Title-0000-Special\_Variables.md
-->

# Special Variables



<!---
Filename: 510-050-Special\_Variables-0000-Chapter-Title.md
-->

## CFEngine Special Variables



<!---
Filename: 510-050-Special\_Variables-0290-Introduction.md
-->

### Introduction2

CFEngine has some special variables.

You can see the whole list in section "Special Variables" in the reference manual, but here is a taste of them.



<!---
Filename: 510-050-Special\_Variables-0300-title\_card.md
-->

### Constants


\begin{codelisting}
\codecaption{510-050-Special\_Variables-0310-Const.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  reports:

      "A carriage return character is $(const.r)The carriage has returned.";

      "A report with a$(const.t)tab in it";

      "Value of variable named $(const.dollar)(const.dollar)
       is $(const.dollar)";

      "The value of variable named \$(const.dollar) is $(const.dollar)";
      # backslash does not work to stop interpolation of the variable

      "A newline with either $(const.n) or with $(const.endl) is ok";
      "But a string with \n in it does not have a newline!";
}
```
\end{codelisting}

<!---
Filename: 510-050-Special\_Variables-0320-Edit.md
-->

### Edit

Special variables with scope "edit" allow you to access information about editing promises during their execution.



### edit.filename
edit.filename
: Points to the filename of the file currently making an edit promise.



\begin{codelisting}
\codecaption{510-050-Special\_Variables-0330-Edit.cf}
```cfengine3, options: "linenos": true
# INPUT
# Put a few text files in /tmp (ending in .txt), and put
# the line "hello world" in one of them.
#
# CFEngine will report which file contains the line "hello world".
#

########################################################

bundle agent main

{
  files:

      "/tmp/.*.txt"
        handle => "cfengine_grep_dash_l",
        comment => "Return files matching given string",
        edit_line => grep_dash_l("hello world");
}

########################################################



bundle edit_line grep_dash_l(regex)
{
  classes:

      "ok" expression => regline("$(regex)","$(edit.filename)");

  reports:

    ok::

      "File $(edit.filename) has a line with \"$(regex)\" in it";

}
```
\end{codelisting}

<!---
Filename: 510-050-Special\_Variables-0340-Match.md
-->

### Match


\begin{codelisting}
\codecaption{510-050-Special\_Variables-0350-Match\_While\_searching\_for\_files.cf}
```cfengine3, options: "linenos": true
# Create the following files before running this example:
# /tmp/cf2_test1
# /tmp/cf3_test2

bundle agent main
{

  files:

      "/tmp/(cf[23])_(.*)"
        edit_line => show_match("$(match.0) $(match.1) $(match.2)");

}

bundle edit_line show_match(data) {

  reports:


      "$(data)";

      # OUTPUT
      # You should see:
      # R: /tmp/cf2_test1 cf2 test1
      # R: /tmp/cf3_test2 cf3 test2

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{510-050-Special\_Variables-0360-Match\_While\_editing\_a\_file.cf}
```cfengine3, options: "linenos": true
#   INPUT
#
#   File /tmp/cf3_test containing a Unix shell style comment:
#
#   one
#   two
#   three
#   # four
#   five
#   six


########################################################

bundle agent main

{

  files:

      "/tmp/cf3_test"

        create    => "true",
        edit_line => replace_shell_comments_with_C_comments;
}

########################################################

bundle edit_line replace_shell_comments_with_C_comments
{

  replace_patterns:

      "#(.*)"

        replace_with => C_comment;

}


########################################################

body replace_with C_comment

{
        replace_value => "/* $(match.1) */"; # backreference 0
        occurrences => "all";  # first, last all
}

########################################################
#
#   OUTPUT
#
#   File /tmp/cf3_test should now have a C style comment:
#
#   one
#   two
#   three
#   /*  four */
#   five
#   six
```
\end{codelisting}

<!---
Filename: 510-050-Special\_Variables-0370-Monitoring.md
-->

### Monitoring


\begin{codelisting}
\codecaption{510-050-Special\_Variables-0380-Mon\_Report\_environmental\_conditions.cf}
```cfengine3, options: "linenos": true
# report environmental conditions
# Current value: value_<name>       e.g. value_diskfree
# Average: av_<name>                e.g. av_diskfree
# Standard Deviation: dev_<name>    e.g. dev_diskfree

bundle agent main {

  reports:

      "
Metric     Current Value
cfengine_in    ${mon.value_cfengine_in}
cfengine_out   ${mon.value_cfengine_out}
cpu            ${mon.value_cpu}
cpu0           ${mon.value_cpu0}
cpu1           ${mon.value_cpu1}
cpu2           ${mon.value_cpu2}
cpu3           ${mon.value_cpu3}
diskfree       ${mon.value_diskfree}
dns_in         ${mon.value_dns_in}
dns_out        ${mon.value_dns_out}
ftp_in         ${mon.value_ftp_in}
ftp_out        ${mon.value_ftp_out}
icmp_in        ${mon.value_icmp_in}
icmp_out       ${mon.value_icmp_out}
irc_in         ${mon.value_irc_in}
irc_out        ${mon.value_irc_out}
loadavg        ${mon.value_loadavg}
messages       ${mon.value_messages}
netbiosdgm_in  ${mon.value_netbiosdgm_in}
netbiosdgm_out ${mon.value_netbiosdgm_out}
netbiosns_in   ${mon.value_netbiosns_in}
netbiosns_out  ${mon.value_netbiosns_out}
netbiosssn_in  ${mon.value_netbiosssn_in}
netbiosssn_out ${mon.value_netbiosssn_out}
nfsd_in        ${mon.value_nfsd_in}
nfsd_out       ${mon.value_nfsd_out}
otherprocs     ${mon.value_otherprocs}
rootprocs      ${mon.value_rootprocs}
smtp_in        ${mon.value_smtp_in}
smtp_out       ${mon.value_smtp_out}
ssh_in         $(mon.value_ssh_in)
ssh_out        ${mon.value_ssh_out}
syslog         ${mon.value_syslog}
tcpack_in      ${mon.value_tcpack_in}
tcpack_out     ${mon.value_tcpack_out}
tcpfin_in      ${mon.value_tcpfin_in}
tcpfin_out     ${mon.value_tcpfin_out}
tcpmisc_in     ${mon.value_tcpmisc_in}
tcpmisc_out    ${mon.value_tcpmisc_out}
tcpsyn_in      ${mon.value_tcpsyn_in}
tcpsyn_out     ${mon.value_tcpsyn_out}
temp0          ${mon.value_temp0}
temp1          ${mon.value_temp1}
temp2          ${mon.value_temp2}
temp3          ${mon.value_temp3}
udp_in         ${mon.value_udp_in}
udp_out        ${mon.value_udp_out}
users          ${mon.value_users}
webaccess      ${mon.value_webaccess}
weberrors      ${mon.value_weberrors}
www_in         ${mon.value_www_in}
www_out        ${mon.value_www_out}
wwws_in        ${mon.value_wwws_in}
wwws_out       ${mon.value_wwws_out}
";
}
```
\end{codelisting}
\begin{codelisting}
\codecaption{510-050-Special\_Variables-0390-Mon\_React\_to\_environmental\_conditions.cf}
```cfengine3, options: "linenos": true
# report environmental conditions

bundle agent main {

  reports:

      "Percent CPU utilization         ${mon.value_cpu}";
      "Percent CPU0 utilization         ${mon.value_cpu0}";
      "Percent CPU1 utilization         ${mon.value_cpu1}";

  classes:
      "CPUoverload"
        expression =>  isgreaterthan("$(mon.value_cpu)","80");

  reports:
    CPUoverload::
      "CPU utilization is over threshold!!!";

}
```
\end{codelisting}

<!---
Filename: 510-050-Special\_Variables-0400-Sys\_Report\_sys\_variables.md
-->

OUTPUT on my system, myhost.example.com

```text
R: sys.arch: x86_64
sys.cdate: Sun_May_15_11_25_03_2011
sys.cf_agent: "/var/cfengine/bin/cf-agent"
sys.cf_execd: "/var/cfengine/bin/cf-execd"
sys.cf_hub: "/var/cfengine/bin/cf-hub"
sys.cf_key: "/var/cfengine/bin/cf-key"
sys.cf_know: "/var/cfengine/bin/cf-know"
sys.cf_monitord: "/var/cfengine/bin/cf-monitord"
sys.cf_promises: "/var/cfengine/bin/cf-promises"
sys.cf_report: "/var/cfengine/bin/cf-report"
sys.cf_runagent: "/var/cfengine/bin/cf-runagent"
sys.cf_serverd: "/var/cfengine/bin/cf-serverd"
sys.cf_twin: "/var/cfengine/bin/cf-agent"
sys.cf_version: 3.1.5
sys.class: linux
sys.date: Sun May 15 11:25:03 2011
sys.domain: example.com
sys.expires:
sys.exports: /etc/exports
sys.fqhost: myhost.example.com
sys.fstab: /etc/fstab
sys.host: myhost.example.com
sys.interface: venet0
sys.ipv4: 127.0.0.1
sys.ipv4[interface_name]: $(sys.ipv4[interface_name])
sys.ipv4_1[interface_name]: $(sys.ipv4_1[interface_name])
sys.ipv4_2[interface_name]: $(sys.ipv4_2[interface_name])
sys.ipv4_3[interface_name]: $(sys.ipv4_3[interface_name])
sys.key_digest: MD5=c4348f13c55363743ba5544a7808dff5
sys.license_owner: $(sys.license_owner)
sys.licenses_granted: $(sys.licenses_granted)
sys.licenses_installtime: $(sys.licenses_installtime)
sys.long_arch:
  linux_x86_64_2_6_18_028stab070_4__1_SMP_Tue_Aug_17_18_32_47_MSD_2010
sys.maildir: /var/spool/mail
sys.nova_version: $(sys.nova_version)
sys.os: linux
sys.ostype: linux_x86_64
sys.policy_hub: $(sys.policy_hub)
sys.release: 2.6.18-028stab070.4
sys.resolv: /etc/resolv.conf
sys.uqhost: myhost
sys.version: #1 SMP Tue Aug 17 18:32:47 MSD 2010
sys.windir: /dev/null
sys.winprogdir: /dev/null
sys.winprogdir86: /dev/null
sys.winsysdir: /dev/null
sys.workdir: /var/cfengine
```



<!---
Filename: 510-050-Special\_Variables-0401-system\_variables\_output.md
-->

Output on my system `myhost.example.com`:

```text
   R: sys.arch: x86_64
   sys.cdate: Sun_May_15_11_25_03_2011
   sys.cf_agent: "/var/cfengine/bin/cf-agent"
   sys.cf_execd: "/var/cfengine/bin/cf-execd"
   sys.cf_hub: "/var/cfengine/bin/cf-hub"
   sys.cf_key: "/var/cfengine/bin/cf-key"
   sys.cf_know: "/var/cfengine/bin/cf-know"
   sys.cf_monitord: "/var/cfengine/bin/cf-monitord"
   sys.cf_promises: "/var/cfengine/bin/cf-promises"
   sys.cf_report: "/var/cfengine/bin/cf-report"
   sys.cf_runagent: "/var/cfengine/bin/cf-runagent"
   sys.cf_serverd: "/var/cfengine/bin/cf-serverd"
   sys.cf_twin: "/var/cfengine/bin/cf-agent"
   sys.cf_version: 3.1.5
   sys.class: linux
   sys.date: Sun May 15 11:25:03 2011
   sys.domain: example.com
   sys.expires: 
   sys.exports: /etc/exports
   sys.fqhost: myhost.example.com
   sys.fstab: /etc/fstab
   sys.host: myhost.example.com
   sys.interface: venet0
   sys.ipv4: 127.0.0.1
   sys.ipv4[interface_name]: $(sys.ipv4[interface_name])
   sys.ipv4_1[interface_name]: $(sys.ipv4_1[interface_name])
   sys.ipv4_2[interface_name]: $(sys.ipv4_2[interface_name])
   sys.ipv4_3[interface_name]: $(sys.ipv4_3[interface_name])
   sys.key_digest: MD5#c4348f13c55363743ba5544a7808dff5
   sys.license_owner: $(sys.license_owner)
   sys.licenses_granted: $(sys.licenses_granted)
   sys.licenses_installtime: $(sys.licenses_installtime)
   sys.long_arch: linux_x86_64_2_6_18_028stab070_4__1_SMP_Tue_Aug_17_18_32_47_MSD_2010
   sys.maildir: /var/spool/mail
   sys.nova_version: $(sys.nova_version)
   sys.os: linux
   sys.ostype: linux_x86_64
   sys.policy_hub: $(sys.policy_hub)
   sys.release: 2.6.18-028stab070.4
   sys.resolv: /etc/resolv.conf
   sys.uqhost: myhost
   sys.version: #1 SMP Tue Aug 17 18:32:47 MSD 2010
   sys.windir: /dev/null
   sys.winprogdir: /dev/null
   sys.winprogdir86: /dev/null
   sys.winsysdir: /dev/null
   sys.workdir: /var/cfengine
```



<!---
Filename: 510-050-Special\_Variables-0410-This.md
-->

### This


\begin{codelisting}
\codecaption{510-050-Special\_Variables-0420-This\_promise\_filename.cf}
```cfengine3, options: "linenos": true

bundle agent main
{
  reports:


      "$(this.promise_filename)";
}

# Let's say this file is called
# 00181_Special_Variables__this_promise_filename.cf
#
# Here is what cf-agent would output if we ran it with
# cf-agent -b example -f \
# ./00181_Special_Variables__this_promise_filename.cf -KI
#
# OUTPUT:
# R: hello world
# R: ./00181_Special_Variables__this_promise_filename.cf
# myhost#
```
\end{codelisting}
\begin{codelisting}
\codecaption{510-050-Special\_Variables-0430-This\_promise\_linenumber.cf}
```cfengine3, options: "linenos": true
# let's say this file is called
# 00182_Special_Variables__this_promise_linenumber.cf

bundle agent main
{
  reports:


      "$(this.promise_linenumber)";
      "$(this.promise_linenumber)";
}

# Here is what you'd see running cf-agent:
#
# myhost# cf-agent -b example \
# -f ./00182_Special_Variables__this_promise_linenumber.cf -KI
# >> Using command line specified bundlesequence
# R: 7
# R: 8
# myhost#
```
\end{codelisting}
\begin{codelisting}
\codecaption{510-050-Special\_Variables-0440-This\_promiser\_transformer\_simple.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/var/log/.*.conf"

        handle => "compress_old_files",
        comment => "Compress files more than 2 days old",
        depth_search => recurse("inf"),
        transformer => "/bin/gzip $(this.promiser)";
}

```
\end{codelisting}
\begin{codelisting}
\codecaption{510-050-Special\_Variables-0450-This\_promiser\_Find\_world\_writable.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/etc/.*"

        file_select => world_writeable,
        transformer => "/bin/echo WORLD WRITABLE FILE: $(this.promiser)";
}


body file_select world_writeable
{
        search_mode => { "o+w" };
        file_result => "mode";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{510-050-Special\_Variables-0460-This\_promiser\_Compress\_pdf\_files.cf}
```cfengine3, options: "linenos": true
#######################################################
#
# Find and compress PDF files
#
#######################################################

bundle agent main

{
  files:

      "/tmp/pdfs"

        file_select => pdf_files,
        transformer => "/usr/bin/gzip $(this.promiser)",
        depth_search => recurse("inf");

}

############################################

body file_select pdf_files

{
        leaf_name => { ".*.pdf" , ".*.fdf" };
      # leaf_name = regex to match on
      # the file NAME (ignoring the
      # full directory path)

        file_result => "leaf_name";
}

############################################

body depth_search recurse(d)

{
        depth => "$(d)";
}

# Given the following files:
#
# /tmp/pdfs/a.pdf
# /tmp/pdfs/b.txt
# /tmp/pdfs/c.pdf
# /tmp/pdfs/d.doc,
#
# Generates the following output (with -I switch):
#
# Transforming: /usr/bin/gzip /tmp/pdfs/a.pdf
# -> Transformer /tmp/pdfs/a.pdf => /usr/bin/gzip /tmp/pdfs/a.pdf
#    seemed to work ok
# Transforming: /usr/bin/gzip /tmp/pdfs/c.pdf
# -> Transformer /tmp/pdfs/c.pdf => /usr/bin/gzip /tmp/pdfs/c.pdf
#    seemed to work ok
#
# and leaves the following files:
#
# /tmp/pdfs/c.pdf.gz
# /tmp/pdfs/b.txt
# /tmp/pdfs/d.doc
# /tmp/pdfs/a.pdf.gz
```
\end{codelisting}
\begin{codelisting}
\codecaption{510-050-Special\_Variables-0470-This\_promiser\_Find\_world\_writable\_files\_but\_not\_symlinks.cf}
```cfengine3, options: "linenos": true
bundle agent main {

  files:

      "/etc/.*"

        file_select => world_writeable_but_not_a_symlink,
        transformer => "/bin/echo FOUND: $(this.promiser)";
}


body file_select world_writeable_but_not_a_symlink
{
        search_mode => { "o+w" };
        file_types => { "symlink" };
        file_result => "mode.!file_types";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{510-050-Special\_Variables-0480-This\_promiser\_In\_commands\_promises.cf}
```cfengine3, options: "linenos": true
# Note: this does not work in 3.1.5; fixed in version 3.2.0.
# Broken again in 3.2.1


bundle agent main {

  commands:

      "/bin/echo $(this.promiser)";

}
```
\end{codelisting}
