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

			// Get and save the message data to the prc
			prc.messageData = wirebox.getInstance( "userModel" ).getMessages();

			// Add a flag to each message if it belongs to the signed in user so they can delete it
			// TODO: This doesnt work, is it possible to add new data into a query result like this?
			// for (var message in prc.messageData) {
			// 	if (message["id"] == prc.userData["id"]) {
			// 		message["isDeletable"] = true
			// 	} else {
			// 		message["isDeletable"] = false
			// 	}
			// }
			
			// Use message IDs to get all comments and save to prc
			// var messageIDs = valueArray(prc.messageData, "messageID")
			// TODO Once we actually have comments in the db
			// prc.commentData = wirebox.getInstance( "userModel" ).getComments( messageIDs=messageIDs );

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
		event.paramValue("username", "")

		// TODO: How to find the lat and long?
		// for now just use a static lat and long

		// TODO: we need to determine the highest ID.... again....
		var highestIDquery = wirebox.getInstance( "userModel" ).getHighestMessageID();
		var highestID = QueryGetRow(highestIDquery, 1)
		var id = LSParseNumber(highestID['id']) + 1

		wirebox.getInstance( "userModel" ).postMessage(
			id=id, 
			username=rc.username,
			message=rc.message,
			timestap=Now(),
			latitude="49.8557953",
			longitude ="20.8093376"
			);
		relocate( "HomePage/index?userID=" & rc.userID);
		event.setLayout("Home")
	}

	/**
	* Delete message
	*/
	function deleteMessage( event, rc, prc ){
			event.paramValue("userID", "")
			event.paramValue("messageID", "")
			wirebox.getInstance( "userModel" ).deleteMessage( messageID=rc.messageID );
			relocate( "HomePage/index?userID=" & rc.userID);
			event.setLayout("Home")
		}
}
