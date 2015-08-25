component {
	this.name = 'firebase-cfml_' & Hash( GetCurrentTemplatePath() );

	this.mappings[ '/testbox' ] = ExpandPath( '../testbox' );
	this.mappings[ '/tests'   ] = ExpandPath( './' );
	this.mappings[ '/aws'   ] = ExpandPath( '../' );

	this.javaSettings = {
		loadPaths: []
	};

	public boolean function onApplicationStart() {

		var env = CreateObject( 'java' , 'java.lang.System' ).getenv();
		var key = "";

		application.firebase_settings = {
			'default_url': 'https://sweltering-heat-6798.firebaseio.com/',
			'default_token': '',
			'default_todo_path': '',
			'delete_path': '',
			'default_set_response': '',
			'default_update_response': '',
			'default_push_response': '',
			'default_': '',
			's3_bucket': ''
		};

		for( key in env ) {
			if (
				StructKeyExists( application.firebase_settings , key )
			) {
				application.firebase_settings[ key ] = env[ key ];
			}
		}

		return true;
	}

}