/**
 * I am a new handler
 */
component{

	// Inject the model
	property name="userModel" inject="UserModel";


	/**
	* index
	*/
	function index( event, rc, prc ){
		
		// lets param a userId in the rc
		event.paramValue("userID", "")

		// get the users data
		// TODO: why cant it find this model?
		// i need to use this wirebox.getinstace or else it wont find the model?
		// var userQuery = userModel.getUserByID( id=rc.userID )
		var userQuery = wirebox.getInstance( "userModel" ).getUserByID( id=rc.userID );
		if (queryRecordCount(userQuery) == 0) {
    		// TODO: 500 server error
		} else {
			// save the data to be displayed on the home screen
			// TODO: in prod we shouldnt be saving or returning passwords
			prc.userData = QueryGetRow(userQuery, 1)
			event.setView( "HomePage/index" );
			event.setLayout("Home")
		}

		// TODO: Get the messages data

	}

	/**
	* Post message
	*/
	function postMessage( event, rc, prc ){
		// lets param a userId in the rc
		event.paramValue("userID", "")

		// retrieve the user's username 
		// generate a timestamp
		// TODO: How to find the lat and long?

		wirebox.getInstance( "userModel" ).postMessage( 
			id=rc.userID, 
			username=username,
			message=rc.message,
			timestap=timestap,
			latitude=latitude,
			longitude =longitude
			);
		event.setView( "HomePage/index" );
		event.setLayout("Home")
	}

	/**
	IMPLICIT FUNCTIONS: Uncomment to use

	function preHandler( event, rc, prc, action, eventArguments ){
	}
	function postHandler( event, rc, prc, action, eventArguments ){
	}
	function aroundHandler( event, rc, prc, targetAction, eventArguments ){
		// executed targeted action
		arguments.targetAction( event );
	}
	function onMissingAction( event, rc, prc, missingAction, eventArguments ){
	}
	function onError( event, rc, prc, faultAction, exception, eventArguments ){
	}
	function onInvalidHTTPMethod( event, rc, prc, faultAction, eventArguments ){
	}
	*/

}
