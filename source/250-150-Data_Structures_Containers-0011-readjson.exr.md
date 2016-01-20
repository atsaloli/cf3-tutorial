Data containers - readjson

1. Turn your array from the previous exercises into
   a JSON data file, e.g.:

phones.json:

{
  "iPhone"  : "$500",
  "Samsung" : "$450"
}

2. Read it into a "data"-type variable with readjson(), e.g.:

  vars:

      "phones"
        data => readjson("$(this.promise_dirname)/phones.json", "100k");

3. Report the contents of the data container

   - get the keys using getindices()
   - iterate over the keys to report the values
