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
		var userQuery = userModel.getUser( rc.email )

		// if a user with that email was not found, return 403
		if (queryRecordCount(userQuery) == 0) {
    		// TODO: How do i return 403 user already exists
			event.renderData( type="json", data={"Error": "User with this email was not found."}, statusCode=403 );


		// A user with that email was found
        } else {
			var userData = QueryGetRow(userQuery, 1)
			// check if the passwords match
			if (rc.password != userData['password']) {
				event.renderData( type="json", data={"Error": "Password does not match this email."}, statusCode=404 );
			} else {
				// SIGN IN SUCCESSFULL
				// else we relocate to the home page
				writeOutput('Sign in successful')
			}
        }
		event.setView("main/index");
	}

	/**
	* Create User request
	*/
	function createUser ( event, rc, prc ) {

		// check if a user with that email exists
		var userQuery = userModel.getUser( rc.email )

		// if a user with that email was not found, create the user
		if (queryRecordCount(userQuery) == 0) {

			// Get the highest id that already exists ( assuming at least one entry exists )
			// TODO: We would need to check that the record set has at least one row
			var highestIDquery = userModel.getHighestID()
			var highestID = QueryGetRow(highestIDquery, 1)
			var id = LSParseNumber(highestID['id']) + 1
			
			// Create the user
			userModel.createUser(
				id = id,
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
