### CFEngine Enterprise - Reporting

How CFEngine Enterprise works:

1. Hubs pull policy from version control (e.g. Git)
2. Hosts pull policy from hubs and execute it and create inventory and compliance reports
3. Hubs download inventory/compliance reports from hosts and aggregate them
4. Humans use hub UI to gain insight into infrastructure:

  - promise compliance (including outliers)
  - changes (repairs)
  - standard and custom inventory
  - reporting interface (custom reports)

CFEngine Enterprise introduces additional components:

- Hub (report collection)
- Mission Portal (Admin/Reporting GUI)
