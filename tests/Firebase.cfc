component extends='testbox.system.BaseSpec' {

	function run() {

		describe( 'Firebase' , function() {

			beforeEach( function( currentSpec ) {
				service = new firebase.firebase(
					baseURI = application.firebase_settings.default_url
				);
			});

			it( 'has a baseURI path stored' , function() {

				makePublic( service , 'getBaseURI' , 'getBaseURI' );

				baseURI = service.getBaseURI();

				expect( baseURI ).notToBeEmpty();

			});

		});

	}
}
