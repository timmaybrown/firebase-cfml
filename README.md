# firebase-cfml

[![Build Status](https://travis-ci.org/mso-net/lucee-aws.svg?branch=master)](https://travis-ci.org/mso-net/lucee-aws)

##CFML REST Wrapper for Firebase

Based on the [Firebase REST API](https://www.firebase.com/docs/rest-api.html).
## Installation

The easiest way to install this at present is to use CommandBox.  To install with CommandBox 2.1+ simply do the following:

```
box install timmaybrown/firebase-cfml --production
```

###Install Sample Apps / Tests
via command box run the following commands to open the box shell clone the repo and start the server.
```
box 
install timmaybrown/firebase-cfml
server start
```
Once commandbox server is started up fill in your Firebase `baseURI` and `token` and then go to the sample app located at:
```
http://localhost:[port]/samples/basic/
//can be reinited with ?reinit=1 
```
examples of the requests and responses will be output along with a final `get()` that shows the results of the various `set()` `update()` `push()` calls. It will clean up after itself by doing a `delete()` simply comment this out if you want to see the end result in the Firebase console or use [Vulcan](https://chrome.google.com/webstore/detail/vulcan-by-firebase/oippbnlmebalopjbkemajgfbglcjhnbl?utm_source=chrome-ntp-icon). 

#####Create a new instance of the cfc
```
var firebaseObj = new your.path.Firebase( 
	baseURI = yourFirebaseURI,
	token = aToken
);
```
#####Token Info
[Firebase User Auth Guide](https://www.firebase.com/docs/rest/guide/user-auth.html)


- If the token is supplied the ?auth={token} will be added to the request path automatically. 
- If the token is omitted the Firebase you are connecting to must allow public access.
- The token can be your secret, but is less secure than generating a JWT that expires or based on a `$uid` with a library like the awesome [cf-simple-jwt](https://github.com/jsteinshouer/cf-jwt-simple)

----------
Make calls on the object now that the path has been established using the available convenience methods each shown below.

###set()
```
firebaseObj.set( path, data );
```
creates or overrides a the node of the path specified.
###update()
```
firebaseObj.update( path, data );
```
adds to or updates the node of the path specified without removing other keys not provided in the data unlike `set()`
###push()
```
firebaseObj.push( path, data );
```
adds an item to the path but firebase creates an auto generated timestamped key. the return is the new created key.

###get()
```
firebaseObj.get( path );
```
retrieves the node of the path. This retrieves all child nodes so "nest" thoughtfully. 

###delete()
```
firebaseObj.delete( path );
```
removes the node of the path.



