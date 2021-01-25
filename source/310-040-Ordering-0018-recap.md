#### Recap

To facilitate convergence, CFEngine evaluates and repairs
promises according to CFEngine "normal ordering" (see [Normal
Ordering](https://docs.cfengine.com/latest/guide-language-concepts-normal-ordering.html)
in CFEngine documentation).

Promises of the same type are evaluated in the order they appear in the file.

Promises of different types are evaluated according to "normal ordering".
