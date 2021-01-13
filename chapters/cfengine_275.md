\begin{codelisting}
\codecaption{275-030-Data\_Structures\_Arrays-0349-array\_simple\_example.cf}
```cfengine3, options: "linenos": false
bundle agent main {

  vars:

      "food_prices[Apple]"
        string =>  "59c";

      "food_prices[Banana]"
        string =>  "30c";

  reports:
      "Apple costs $(food_prices[Apple])";
      "Banana costs $(food_prices[Banana])";

}
```
\end{codelisting}
\begin{codelisting}
\codecaption{275-030-Data\_Structures\_Arrays-0350-Arrays\_Array\_of\_strings.cf}
```cfengine3, options: "linenos": false
bundle agent main {
  vars:
      "cfengine_components[cf-monitord]"
        string => "The monitor";

      "cfengine_components[cf-serverd]"
        string => "The server";

      "cfengine_components[cf-execd]"
        string => "The executor";

      "component_names"
        comment => "Extract keys from cfengine_components array",
        slist => getindices("cfengine_components");

  reports:
#    "Key = '$(component_names)'";
#    "Value = $(cfengine_components[$(component_names)])";

    "Key '$(component_names)' = Value $(cfengine_components[$(component_names)])";




}

```
\end{codelisting}
<!---                 
Filename: 275-030-Data\_Structures\_Arrays-0355-array.exr.md
-->

\begin{aside}
\label{aside:exercise_22}
\heading{Using arrays}


Make an array (key/value collection) with two elements

* Print the value of one element from this array (using the key)

* Now print contents of the array using the getindices()
function to get a list of keys, and then iterate over the
keys to extract the values.


\end{aside}
\begin{codelisting}
\codecaption{275-050-Data\_Structures\_Containers-0010-readjson.cf}
```cfengine3, options: "linenos": false
bundle agent main_0 {

  vars:
      "food"
        data => parsejson('{
                            "Lunch" : "Pizza",
                            "Dinner" : "Roast Beef"
                           } ');


  reports:

      "Lunch = $(food[Lunch])";
      "Dinner = $(food[Dinner])";
}









bundle agent main {

  vars:
      "food"
        data => parsejson('{
                            "Lunch" : "Pizza",
                            "Dinner" : "Roast Beef"
                           } ');

       "meals" 
         slist => getindices("food");
  reports:

      "My meals:  $(meals)";
      "My meals:  $(meals) : $(food[$(meals)])";
#comment => "see /tmp/myexecisedatacontainers.txt";
}
 

```
\end{codelisting}
