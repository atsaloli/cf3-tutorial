Run the following command to generate some content:

```bash
date  > /tmp/date.txt
```

Write a CFEngine policy that will comment out (using #)
all lines that start with a day of the week:


    edit_line => comment_lines_matching("(Mon|Tue|Wed|Thur|Fri|Sat|Sun).*" ,
                                        "#")

The `edit_line` bundle `comment_lines_matching` is in the standard
library.
