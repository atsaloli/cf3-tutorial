File editing: replacing text

Given a file '/tmp/file.txt':

```text
apples
oranges
```

Use the CFEngine Standard Library to comment out "oranges" and append "bananas", resulting in:

```text
apples
# oranges
bananas
```

Hint: use the following:
* bundle edit_line insert_lines
* bundle edit_line comment_lines_matching
