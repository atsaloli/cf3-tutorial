#### Implicit Looping

If you refer to a list variable in scalar context by using `$(identifier)`,
CFEngine will implicitly loop over the values of `@(list)`.
