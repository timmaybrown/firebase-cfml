<cfscript>
	function exitCode( required numeric code ) {
		var exitcodeFile = GetDirectoryFromPath( GetCurrentTemplatePath() ) & "/.exitcode";
		FileWrite( exitcodeFile, code );
	}
	try {
		reporter = cgi.server_protocol == "CLI/1.0" ? "text" : "simple";
		testbox  = new testbox.system.TestBox( options={}, reporter=reporter, directory={
			  recurse  = true
			, mapping  = "tests"
			, filter   = function( required path ){ 
				return ( ListLast( arguments.path , '/' ) != 'Application.cfc' );
			}
		} );
		echo( testbox.run() );
		resultObject = testbox.getResult();
		errors       = resultObject.getTotalFail() + resultObject.getTotalError();
		exitCode( errors ? 1 : 0 );
	} catch ( any e ) {
		echo( "An error occurred running the tests. Message: [#e.message#], Detail: [#e.detail#]" );
		exitCode( 1 );
	}
</cfscript>