
<!---
Filename: 600-000-Part-Title-0000-Monitoring.md
-->

# Monitoring and Anomaly Detection

If you are running cf-monitord, you may also see *anomaly detection* and *entropy* classes.

> Cfengine expects systems to change dynamically, so it allows users to define a policy for allowed change.
>
> -- Mark Burgess

CFEngine comes with an anomaly detection engine, cf-monitord.

> Although it is not a compulsory part of cfengine, it is highly recommended to run this daemon. It requires few resources and poses no vulnerability to the system. It will play an increasingly important role in future developments.
>
> -- Mark Burgess

In CFEngine,  additional classes are automatically evaluated by cf-monitord based on the state of the host, in relation to earlier times.

cf-monitord continually updates a database of system averages and variances, which characterize
"normal" behaviour. The state of the system is examined and compared to the database,
and the state is classified in terms of the current level of activity, as compared to an average
of equivalent earlier times.

## Anomaly Detection

cf-monitord estimates the level of normality.

When cf-monitord has accurate knowledge of statistics, it classifies the current state into 4 levels: 

*normal*
: means that the current level is less than one standard deviation above normal.

*dev1*
: means that the current level is at least one standard deviation about the average.

*dev2*
: means that the current level is at least two standard deviations about the average.

*anomaly*
: means that the current level is more than 3 standard deviations above average. 

*microanomaly*
: The cf-monitord evaluates its data and decides whether or not the data are too noisy to be really useful. If the data are too noisy but the level appears to be more than two standard deviations above aaverage, then the category microanomaly is used. 


Examples:

`smtp_high_dev1` - the current value of the metric is more than 1 standard deviation above the average.

`loadavg_high_ldt` - load average higher than usual (based on Leap-Detection Test)

## Entropy classes

To provide additional information, cf-monitord sets entropy classes.

A low entropy value means that most of the events came from only a few (or one) IP addresses. A high entropy value implies that the events were spread over many IP sources.

Examples (from an idle system):

```text
entropy_cfengine_in_low
entropy_cfengine_out_low
entropy_dns_in_low
entropy_dns_out_low
entropy_ftp_in_low
entropy_ftp_out_low
entropy_irc_in_low
entropy_irc_out_low
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
```

To learn more, see ["Anomaly detection with cfenvd"](http://www.iu.hio.no/cfengine/docs/cfengine-Anomalies.pdf) 
("cfenvd" was the original name of the CFEngine environmental monitoring daemon in CFEngine 2) and
["Monitoring with CFEngine"](https://auth.cfengine.com/archive/manuals/st-monitoring) (a CFEngine 3.0 document).


\coloredtext{red}{ 600-000-Part-Title-0000-Monitoring.md }

