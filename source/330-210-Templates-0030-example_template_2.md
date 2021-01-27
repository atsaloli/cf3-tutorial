### Expanding the Template

You "expand" the template by populating it with data:

```console
$ cat /tmp/letter.template
Hello __NAME__,

  Please buy our product.

Love,
Company

$ NAME=John
$ sed -e "s:__NAME__:${NAME}:" < letter.template >  letter.txt
$ cat letter.txt
Hello John,

  Please buy our product.

Love,
Company

$
```
