/**
 * Firebase CFML Client Library
 *
 * @author Tim Brown <timmay.brown@gmail.com>
 * @url    https://github.com/timmaybrown/firebase-cfml/
 * @link   https://www.firebase.com/docs/rest-api.html
 * 
 * @output false
 *
 */
component accessors="true" {

    property name='baseURI' type='string' getter="true" setter="false";    
    property name='timeout' type='string' default="10" getter="false" setter="false"; 
    property name='token' type='string' getter="false" setter="false"; 

    /**
     * init()
     *
     * @hint constructor function
     */
    public Firebase function init(
        required string baseURI, 
        string token = '',
        string timeout = '10'
    ) {

        setToken( arguments.token ); 
        setBaseURI( arguments.baseURI ); 
        setTimeout( arguments.timeout ); 

        return this;
    }

    /**
     * setToken()
     *
     * @hint sets the baseURI after normalizing it with a trailing slash
     */
    public void function setToken( required string token ) {
        variables.token = arguments.token;
    }

    /**
     * setBaseURI
     *
     * @hint sets the baseURI after normalizing it with a trailing slash
     */
    public void function setBaseURI( required string uri ) {
        arguments.uri &= (right(arguments.uri, 1) == '/' ? '' : '/');
        variables.baseURI = arguments.uri;
    }

    /**
     * setTimeout()
     *
     * @hint sets the baseURI after normalizing it with a trailing slash
     *
     */
    public void function setTimeout(seconds) {
        variables.timeout = arguments.seconds;
    }

    /**
     * set()
     *
     * @hint sets the data in the firebase path specified
     *
     */
    public array function set( required string path, required any data ) {
      return _sendRequest( path, 'PUT', data );
    }

    /**
     * push()
     *
     * @hint does a post the
     *
     */
    public array function push( required string path, required any data ) {
      return _sendRequest( path, 'POST', data );
    }

    /**
     * update()
     *
     * @hint Named children in the data being written with this method will be PATCHed, but omitted children will not be deleted
     *
     */
    public array function update( required string path, required any data ) {
      return _sendRequest( path, 'PATCH', data );
    }

    /**
     * get()
     *
     * @hint retreive the data from the firebase resource path
     *
     */
    public any function get( required string path ) {
        var res = "";

        try {
            return _sendRequest( path, 'GET' );
        } catch ( any e ) {
            return null;
        }
    }

    /**
     * delete()
     *
     * @hint delete the data at the specified path
     */
    public function delete( required string path ) {
        try {
            return _sendRequest( path, 'DELETE' );
        } catch ( any e ) {
            $return = null;
        }
    }

    /**
     * _sendRequest()
     *
     * @hint do the HTTP request
     */
    private function _sendRequest( path, method = 'PUT', data = "", querystring = "" ) {
        //default headers
        var headers = [
            { "name" = "Content-Type", value = "application/json" }
        ];

        // instantiate the service
        var httpService = new http();
        
        // set the URL to the path provided ?auth will be appended by _getJsonPath() if token has been set
        var url = _getJsonPath( path );

        httpService.setURL( _getJsonPath( path ) );
        httpService.setCharset( "utf-8" ); 
        httpService.setMethod( arguments.method );

        // if data is supplied serialize it, set length header and add it as the body param
        if ( len( arguments.data ) ) {
            var jsonData = serializeJSON( arguments.data );
            arrayAppend(headers, { "name" = "Content-Length", "value" = len( jsonData ) } );
            httpService.addParam( type = "body", value = jsonData );
        }

        for ( var h in headers ) {
            httpService.addParam( type = "header", name = h.name, value = h.name );
        }

        return httpService.send().getPrefix();
    }

    /**
     * _getJsonPath
     *
     * @hint Returns with the normalized JSON absolute path
     */
    private string function _getJsonPath( required string path )  {

        path = reReplace(trim(path), "^/", "") & ".json";
        var auth = (variables.token == "") ? "" : "?auth=" & variables.token;
        return variables.baseURI & path & auth;
    }


}