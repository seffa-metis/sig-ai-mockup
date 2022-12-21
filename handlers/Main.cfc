component extends="coldbox.system.EventHandler" {

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
	 function createUser (event, rc, prc ) {
		// read the db for a user with the given rc.email
		// --	if it exist, return 403 user already exists
		// if it doesnt exists, save the rc.email, rc.password, and rc.username to the user table
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
