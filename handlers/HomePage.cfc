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
		
		// TODO: If no user was found, return to sign in page probably
		if (userQuery.recordCount == 0) {
    		// TODO: 500 server error
			return
		} else {
			// save the data to be displayed on the home screen
			// TODO: in prod we shouldnt be saving or returning passwords
			prc.userData = QueryGetRow(userQuery, 1)

			// TODO: get and save the message data to the prc
			prc.messageData = wirebox.getInstance( "userModel" ).getMessages( quantity="10" );

			
			event.setView( "HomePage/index" );
			event.setLayout("Home")
		}

		

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



}
