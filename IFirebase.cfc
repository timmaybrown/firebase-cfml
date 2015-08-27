interface {

    public Firebase function init(
        required string baseURI, 
        string token = '',
        string timeout = '10'
    );

    public void function setToken( required string token );

    public void function setBaseURI( required string uri );

    public void function setTimeout( required numeric seconds );

    public any function get( required string path );

    public any function set( required string path, required any data );

    public any function push( required string path, required any data );

    public any function update( required string path, required any data );

    public any function delete( required string path );

}