Render a JSON-backed Mustache template

1. Make a JSON file
 
   Example:

     food.json:

     { "food" : "pizza" }


2. Make a Mustache template

   Example:

     order.mustache:

     Waiter, I'd like to order {{food}}

3. Write CFEngine policy that will render the Mustache 
   template using the data in the JSON file (hint:
   see readjson() function)


