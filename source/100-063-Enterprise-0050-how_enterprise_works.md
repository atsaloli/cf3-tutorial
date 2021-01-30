### CFEngine Enterprise - Reporting

CFEngine Enterprise unlocks unparalleled insight into infrastructure:

- promise compliance (including outliers)
- changes (repairs)
- inventory and compliance reports (at any level of abstraction -- from
  enterprise-wide down to an individual host)

CFEngine Enterprise components:

- Hub (report collection and admin UI)
- Super-Hub (reporting UI, for large enterprises)

How reporting works:

1. Hubs pull policy from version control (e.g. Git)
2. Hosts pull policy from hubs and execute it and create inventory and
   compliance reports
3. Hubs download inventory/compliance reports from hosts and aggregate them

