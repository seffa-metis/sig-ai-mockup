component extends="coldbox.system.EventHandler" {

	// Inject the model
	property name="userModel" inject="UserModel";

	/**
	 * Sign in / sign up page
	 */
	function index( event, rc, prc ) {
		event.setView("main/index");
	}

	/**
	* Sign in request
	*/
	function signIn (event, rc, prc ) {
		// read the db for a user with the given rc.email
		// --	if it doesnt exist, return 403 not found
		// if it exists, check the queried pw against the rc.password
		// --	if it doesnt match, return 400 error
		// if they match set view to be main home page
	}

	/**
	* Create User request
	*/
	function createUser ( event, rc, prc ) {

		// check if a user with that email exists
		var userQuery = userModel.getUser( rc.email )

		// if a user with that email was not found, create the user
		if (queryRecordCount(userQuery) == 0) {
			
			// Get a struct from the query record set
			var userData = QueryGetRow(userQuery, 1)

			// Create the user
			userModel.createUser(
				id = '9996',
				firstname = rc.firstname,
				lastname = rc.lastname,
				username = rc.username,
				email = rc.email,
				password = rc.password,
				timezone = rc.timezone
			)

		// A user with that email already exists
        } else {

        	// TODO: How do i return 403 user already exists
			event.renderData( type="json", data={"Error": "User already exist"}, statusCode=403 );
        }
		event.setView("main/index");
	}

	/**
	 * Produce some restfulf data
	 */
	function data( event, rc, prc ) {
		return [
			{ "id" : createUUID(), name : "Luis" },
			{ "id" : createUUID(), name : "JOe" },
			{ "id" : createUUID(), name : "Bob" },
			{ "id" : createUUID(), name : "Darth" }
		];
	}

	/**
	 * Relocation example
	 */
	function doSomething( event, rc, prc ) {
		relocate( "main.index" );
	}

	/************************************** IMPLICIT ACTIONS *********************************************/

	function onAppInit( event, rc, prc ) {
	}

	function onRequestStart( event, rc, prc ) {
		// TODO: Authentication here
	}

	function onRequestEnd( event, rc, prc ) {
	}

	function onSessionStart( event, rc, prc ) {
	}

	function onSessionEnd( event, rc, prc ) {
		var sessionScope     = event.getValue( "sessionReference" );
		var applicationScope = event.getValue( "applicationReference" );
	}

	function onException( event, rc, prc ) {
		event.setHTTPHeader( statusCode = 500 );
		// Grab Exception From private request collection, placed by ColdBox Exception Handling
		var exception = prc.exception;
		// Place exception handler below:
	}

}
