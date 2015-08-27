component {

	public struct function demo( firebase_settings ) {

		var stRet = {
			"success" = true,
			"msg" = "",
			"detail" = "",
			"results" = []
		};

		// if ( !len(firebase_settings.baseURI) || !len(firebase_settings.token) ) {
		// 	return stRet;
		// }

		try {
		
			var firebaseObj = new main.Firebase( 
				baseURI = firebase_settings.baseURI, 
				token = firebase_settings.token
			);

			var tickCount = getTickCount();
			var thePath = '/cfml-sample-basic/';

			var stSet = {
				"code" : "firebaseObj.set( path, data );",
				"path" : thePath,
				"desc" : "create or update a node at the path specified. This method will override any other keys at this path with the payload.",
				"req" : { 
					"key1" = "This is a key that gets set on node creation",
					"key2" = "This is a key that gets set on node creation. Will be updated later."
				},
				"res" : {}
			};
			stSet.res = firebaseObj.set( thePath, stSet.req );

			var stUpdate1 = {
				"code" : "firebaseObj.update( path, data );",
				"path" : thePath,
				"desc" : "Changed the value of key2 but key1 is left untouched unlike a set() operation would do",
				"req" : { 
					"key2" = "This key has now been updated but key1 hasn't been touched"
				},
				"res" : {}
			};
			stUpdate1.res = firebaseObj.update( thePath, stUpdate1.req );

			var stUpdate2 = {
				"code" : "firebaseObj.update( path, data );",
				"path" : thePath,
				"desc" : "added a new key to the node other existing keys are left un-touched.",
				"req" : { 
					"key3" = "This key was added wasn't in the original set() operation. Leaving key1 and key2 alone"
				},
				"res" : {}
			};
			stUpdate2.res = firebaseObj.update( thePath, stUpdate2.req );

			var stPush1 = {
				"code" : "firebaseObj.push( path, data );",
				"path" : thePath & 'msgs/',
				"desc" : "Add to the messages collection with auto time-stamped key",
				"req" : { "msg" = "obligatory" },
				"res" : {}
			};
			stPush1.res = firebaseObj.push( thePath & 'msgs/', stPush1.req );

			var stPush2 = {
				"code" : "firebaseObj.push( path, data );",
				"path" : thePath & 'msgs/',
				"desc" : "Add to the messages collection with auto time-stamped key",
				"req" : { "msg" = "hello" },
				"res" : {}
			};
			stPush2.res = firebaseObj.push(  thePath & 'msgs/', stPush2.req );

			var stPush3 = {
				"code" : "firebaseObj.push( path, data );",
				"path" : thePath & 'msgs/',
				"desc" : "Add to the messages collection with auto time-stamped key",
				"req" : { "msg" = "world" },
				"res" : {}
			};
			stPush3.res = firebaseObj.push(  thePath & 'msgs/', stPush3.req );

			var stPush4 = {
				"code" : "firebaseObj.push( path, data );",
				"path" : thePath & 'msgs/',
				"desc" : "Add to the messages collection with auto time-stamped key",
				"req" : { "msg" = "the collection key is a timestamped auto-generated text value." },
				"res" : {}
			};
			stPush4.res = firebaseObj.push(  thePath & 'msgs/', stPush4.req );

			var stGetNode = {
				"code" : "firebaseObj.get( path );",
				"path" : thePath,
				"desc" : "Get all the data in the node of the path the demo uses to show the end result of the operations.",
				"res" : {}
			};
			stGetNode.res = firebaseObj.get( thePath );

			var stDelete = {
				"path" : thePath,
				"code" : "firebaseObj.delete( path );",
				"desc" : "Removes the node of the specified path",
				"res" : {}
			};
			stDelete.res = firebaseObj.delete( thePath );

			stRet.results = [
				stSet,
				stUpdate1,
				stUpdate2,
				stPush1,
				stPush2,
				stPush3,
				stPush4,
				stGetNode,
				stDelete
			];

			return stRet;
		
		} catch(any e) {
			stRet = {
				"success" = false,
				"msg" = e.message,
				"detail" = e.detail,
				"results" = []
			};

			return stRet;
			
		}
		
	}

}