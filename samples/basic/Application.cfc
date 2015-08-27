component {
	this.name = 'firebase-cfml-sample-basic_' & Hash( GetCurrentTemplatePath() );

	this.mappings[ '/main'   ] = ExpandPath( '../../' );
	this.mappings[ '/root'   ] = ExpandPath( '.' );


	public boolean function onApplicationStart() {



		//FIREBASE
		APPLICATION.firebase_settings = {
			// the URI of your firebase
			'baseURI' = ""
			// the token is what's passed as the ?auth URL param .. can be any value listed at the url below
			// https://www.firebase.com/docs/rest/guide/user-auth.html#section-authenticating-servers
			,'token' = ""
		};



		return true;
	}

	public function onRequestStart() {

		//reinit 
		if ( structKeyExists( URL, "reinit" ) ) onApplicationStart();

	}
}