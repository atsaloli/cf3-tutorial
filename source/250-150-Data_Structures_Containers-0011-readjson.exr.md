### Data containers - readjson

1. Turn your array from the previous exercises into
   a JSON data file, example.json

{
  "iPhone" : "500$",
  "Samsung" : "450$",
}

2. Read it in a "data" type variable using readjson()
   function

  vars:

      "mydata"
        data => readjson("/path/to/example.json", 100k);

3. Report its contents   
   - get the keys using getindices()
   - iterate over the keys to report the values
  vars:
      "keys"
        slist => getindices("mydata");
  reports:
      "$(keys)  $(mydata[$(keys)])";
