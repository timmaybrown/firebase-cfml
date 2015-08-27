/**
 * Firebase CFML REST Client Library
 *
 * @author Tim Brown <timmay.brown@gmail.com>
 * @url    https://github.com/timmaybrown/firebase-cfml/
 * @link   https://www.firebase.com/docs/rest-api.html
 * 
 * @output false
 *
 */
component accessors="true" implements="IFirebase" {

    property name='baseURI' type='string' getter="true" setter="false";    
    property name='timeout' type='numeric' default="10" getter="false" setter="false"; 
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
    public void function setTimeout(required numeric seconds) {
        variables.timeout = arguments.seconds;
    }

    /**
     * get()
     *
     * @hint retreive the data from the firebase resource path
     *
     */
    public any function get( required string path ) {
        return _sendRequest( path, 'GET' );
    }

    /**
     * set()
     *
     * @hint sets the data in the firebase path specified
     *
     */
    public any function set( required string path, required any data ) {
      return _sendRequest( path, 'PUT', data );
    }

    /**
     * push()
     *
     * @hint does a post the
     *
     */
    public any function push( required string path, required any data ) {
      return _sendRequest( path, 'POST', data );
    }

    /**
     * update()
     *
     * @hint Named children in the data being written with this method will be PATCHed, but omitted children will not be deleted
     *
     */
    public any function update( required string path, required any data ) {
      return _sendRequest( path, 'PATCH', data );
    }

    /**
     * delete()
     *
     * @hint delete the data at the specified path
     */
    public any function delete( required string path ) {
        return _sendRequest( path, 'DELETE' );
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
        var urlPath = _getJsonPath( path );

        httpService.setURL( urlPath );
        httpService.setCharset( "utf-8" ); 
        httpService.setMethod( arguments.method );

        // if data is supplied serialize it, set length header and add it as the body param
        if ( !isSimpleValue(arguments.data) ) {
            var jsonData = serializeJSON( arguments.data );
            arrayAppend(headers, { "name" = "Content-Length", "value" = len( jsonData ) } );
            httpService.addParam( type = "body", value = jsonData );
        }

        for ( var h in headers ) {
            httpService.addParam( type = "header", name = h.name, value = h.name );
        }

        var result = httpService.send().getPrefix();

        if (!isJson(result.fileContent)) {
           throw('Error: ' & result.fileContent );
        } else {
            return deserializeJson(result.fileContent);
        }

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