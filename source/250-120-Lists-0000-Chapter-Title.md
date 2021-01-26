### List Variables

A list is a collection of scalars (single values).

A list variable is represented as `@(identifier)` or
`@(bundlename.identifier)`.

Lists are typed: you can have lists of strings, lists of integers, and lists of reals.

If you refer to a list variable in scalar context by using `$(identifier)`,
CFEngine will implicitly loop over the values of `@(list)`.
