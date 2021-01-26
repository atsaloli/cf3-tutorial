### Introducing templates

What are templates?  Why would we use templates?

(In class, a brief introductory talk is given for sysadmins that haven't worked with templates.)

In the following templates, we use an uncommon text string (double underscore) to set out our tokens from the rest of the text. This will make it easy to find and replace the tokens with their values (to fill in the template with values) without accidentally replacing actual text.

### Example email template:
```text
Hello __NAME__,

  Please buy our product.

Love,
Company
```

You can expand this template with a shell command:

```bash

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
