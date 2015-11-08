List contents

List the collection contents:

I've created a shell script to list the collection
contents. It indents the part and chapter headings
to provide a sort of Table of Contents.

Try running it:

```bash
./l.sh
```

Notice the content is structured (the files are numbered).
The materials proceed in sequence from basic to advanced.

However, if you need to find something, the quickest way may be to just grep for it, e.g. to find an example of `process_stop`:

```bash
grep -l process_stop *.cf
```

If the `l.sh` script does not work on your system, use

```bash
ls *.cf
```

and [let me know](mailto:aleksey@verticalsysadmin.com).
