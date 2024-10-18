component extends="coldbox.system.EventHandler" {

	// Inject the model
	property name="userModel" inject="UserModel";
	
	/**
	* Sign in / sign up page
	*/
	function index( event, rc, prc ) {
		event.setLayout("Main");
		event.setView("main/index");
	}
	
	/**
	* Sign in request
	*/

	
	/**
	* Create User request
	*/

	
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
	