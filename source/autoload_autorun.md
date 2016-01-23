Autoload and autorun

CFEngine 3.6 introduced the autoload/autorun facility to make it
easier to add promises.

To enable autoload/autorun, edit masterfiles/controls/3.7/def.cf:

  change  "services_autorun" expression => "!any";
  to      "services_autorun" expression => "any"

Autoload/autorun will add *.cf files in services/autorun/
to the inputs list, and will run bundles tagged with
the "autorun" tag.

To tag your bundle for autorun, add this meta promise:

   meta: "tags" slist => { "autorun" };

Purging policies

In masterfiles/controls/3.7/def.cf and in update_def.cf:

  change  "cfengine_internal_purge_policies" expression => "!any";
  to      "cfengine_internal_purge_policies" expression => "any";


Put your files in masterfiles/services/autorun/ and they
will be automatically loaded by the autorun facility (invoked
from promises.cf).
