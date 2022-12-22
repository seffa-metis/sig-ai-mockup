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
