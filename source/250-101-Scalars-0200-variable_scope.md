### Scope of variables

There is no scope.

All variables in CFEngine are globally accessible.

However, if you refer to a variable by `$(unqualified)`, then it is
assumed to belong to the current bundle. To access any other scalar
variable, you must qualify the name, using the name of the bundle in
which it is defined, `$(bundle_name.qualified)`.
