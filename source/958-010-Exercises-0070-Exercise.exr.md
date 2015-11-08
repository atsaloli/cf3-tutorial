File editing: preserving a block while inserting it

Insert the following three lines (and you can keep them in order, as a single block, using insert_lines attribute insert_type => "preserve_block";) into /etc/profile BEFORE the HOSTNAME=... line.  (Hint: look at the "location" attribute of insert_lines)

```bash
if [ -x /bin/custom ]
  then /bin/custom
fi
```

