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
	var userQuery = userModel.getUserByEmail( rc.email )

	// if a user with that email was not found, return 403
	if (queryRecordCount(userQuery) == 0) {
		event.renderData( type="json", data={"Error": "User with this email was not found."}, statusCode=403 );
		return
	} 

	// A user with that email was found, so get his data
	var userData = QueryGetRow(userQuery, 1)

	// check if the passwords match
	if (rc.password != userData['password']) {
		event.renderData( type="json", data={"Error": "Password does not match this email."}, statusCode=404 );
		return
	} 

	// User sign in is successful, redirect to the home page
	return userData["id"]
}

/**
* Create User request
*/
function createUser ( event, rc, prc ) {

	// check if a user with that email exists
	var userQuery = userModel.getUserByEmail( rc.email )

	// if a user with that email already exists, return an error
	if (userQuery.recordcount != 0) {
		event.renderData( type="json", data={"Error": "User already exist"}, statusCode=403 );
		}

	// NOTE: This should never happen in prod as or db should have autoincrimenting id's
	// Get the highest id that already exists ( assuming at least one entry exists )
	var highestIDquery = userModel.getHighestUserID()
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
	event.setView("main/index");
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
