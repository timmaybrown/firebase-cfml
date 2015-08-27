<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Basic Sample App : Firebase CFML REST Wrapper</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- Leave those next 4 lines if you care about users using IE8 -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <style type="text/css">
			div.page-content {
				margin-top:60px;
			}
    </style>
  </head>
  <body>

		<cfscript>
			basicObj = new root.basic();
			demo = basicObj.demo( application.firebase_settings );
		</cfscript>

		<!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">firebase-cfml</a>
            </div>
        </div>
        <!-- /.container -->
    </nav>

    <div class="page-content">
	    <div class="container">
					<div class="row">
						<div class="jumbotron well">
						  <h2>Firebase CFML REST Library : Basic Sample App</h2>
							<h4>Sample application that creates, updates, adds, gets and cleans up after itself at the firebase endpoint specified in Application.cfc</h4>

						</div>
					</div>
	        <div class="row">
	          <div class="col-lg-12">
	          	<cfoutput>
	          		<!--- IF WE HAVE AN ARRAY LEN THEN they have a proper setup.. --->
	          		<cfif demo.success && arrayLen(demo.results)>

		              <cfloop array="#demo.results#" index="result">
					
										<div class="panel panel-default">
											<div class="panel-heading">
										    <strong><code>#result.code#</code></strong>
										  </div>
										  <div class="panel-body">
												
										  	<!--- REQUEST --->
										    <cfif structKeyExists( result, "req" )>
										    	<!--- RESULT --->
													<strong>REQUEST DATA</strong><br/>
											    <code>#serializeJSON(result.req)#</code><br/><br/>
												</cfif>

										  	<!--- RESULT --->
												<strong>RESULT</strong><br/>
												<cfif !isNull( result.res) >
										    	<code>#serializeJSON(result.res)#</code>
										    <cfelse>
										    	<code>#serializeJSON('null')#</code>
												</cfif>
										  </div>
										  <div class="panel-footer">
												#result.desc#
										  </div>
										</div>

									</cfloop>
								
								<cfelse>
									
									<div class="panel panel-danger">
										<div class="panel-heading">
									    <h3 class="panel-title">Error Details</h3>
									  </div>
									  <div class="panel-body">
												<code>#demo.msg#</code>
									  </div>
									</div>
									<div class="panel panel-primary">
										<div class="panel-heading">
									    <h3 class="panel-title">APPLICATION.cfc :: <code>##application.firebase_settings##</code></h3>
									  </div>
									  <div class="panel-body">
									  	<div class="alert alert-warning">
												<strong>Currently Configured Firebase Settings.</strong> Please confirm your Firebase URI and token if you are encountering an error.<br/>

												<a href="https://www.firebase.com/docs/rest/guide/user-auth.html##section-authenticating-servers">https://www.firebase.com/docs/rest/guide/user-auth.html##section-authenticating-servers</a>
												
											</div>
											<cfset keys = listToArray(structKeyList( application.firebase_settings ))>

											<pre>{<cfloop array="#keys#" index="i">
	"#i#" = "#APPLICATION.firebase_settings[i]#",</cfloop>
}</pre>
										</div>
									</div>

								</cfif>
	          	</cfoutput>
	          </div>
	        </div>
	        <!-- /.row -->

	    </div>
	  </div>
    <!-- /.container -->
  
  </body>
</html>