Episode 11 -- JSON
=====================

Return JSON (tested) in Sinatra and Rabl

Panda Level
-----------

1. Add an attribute named `:execution_time` to the LogRequest
2. Make sure to test that it is included in the JSON result

Tiger Level
-----------

1. Implement a post "/" that will log the request 
2. Receive JSON on the post and insert the record into the in-memory store
3. Write a test that confirms that you can post a log entry and read it back on a subsequent call

Eagle Level
-----------

1. Implement a user scheme, where a User object has a unique code
2. If I pass in the "code" as a parameter to get "/", then it only returns _my_ logs
3. Make the code be required on the post. Return a 401 error code if it is not present

Copyright
---------

Copyright: 2012 Jesse Wolgamott, MIT License (See LICENSE)
