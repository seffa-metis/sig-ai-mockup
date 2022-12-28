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

	/**
	* Delete comment
	*/
	function deleteComment( event, rc, prc ){
			event.paramValue("userID", "")
			event.paramValue("commentID", "")
			wirebox.getInstance( "userModel" ).deleteComment( commentID=rc.commentID );
			relocate( "HomePage/index?userID=" & rc.userID);
			event.setLayout("Home")
		}

	/**
	* Post comment
	*/
	function postComment( event, rc, prc ){
		event.paramValue("userID", "")
		event.paramValue("messageID", "")
		event.paramValue("userDisplayName", "")

		wirebox.getInstance( "userModel" ).postComment(
			messageID=rc.messageID,
			userID=rc.userID,
			comment=rc.comment,
			userdisplayname =rc.userDisplayName
			);
		relocate( "HomePage/index?userID=" & rc.userID);
		event.setLayout("Home")
	}

	/**
	* Get comments for a post
	*/
	function getComments( event, rc, prc ) {
		prc.commentData = StructNew()
		var commentData = wirebox.getInstance( "userModel" ).getComments();
	}

	/**
	* Get user by id
	*/
	function getUserByID( event, rc, prc ) {
		event.paramValue("userID", "")
		var userDataQuery = wirebox.getInstance( "userModel" ).getUserByID( id=rc.userID )
		return QueryGetRow(userDataQuery, 1)
	}

	/**
	* Update user
	*/
 	function updateUser( event, rc, prc ) {
		event.paramValue("userID", "")

		// Get the user's current information
		var currentUserQuery = wirebox.getInstance( "userModel" ).getUserByID( rc.userID )
		var userInfo = QueryGetRow(currentUserQuery, 1)

		// Check to see if user with this email or username already exist
		var emailCheckQuery = wirebox.getInstance( "userModel" ).getUserByEmail( rc.email )

		// If they changed their email, no records will be found
		// If they didnt change their email, one matching record will be found
		// If thats the case, we need to make sure it matches their previous email, and not an 
		// email of another user.
		writeDump(emailCheckQuery.recordcount == 1)
		writeDump(userInfo["email"])
		writeDump(emailCheckQuery["email"])
		var email1 = userInfo["email"]
		var email2 = emailCheckQuery["email"]
		writeDump(email1 != email2)
	
		if (emailCheckQuery.recordcount == 1 AND email1 != email2) {
			writeDump("HERE")
			event.renderData( type="json", data={"Error": "User with this email already exists."}, statusCode=403 );
			return
		}

		wirebox.getInstance( "userModel" ).updateUser(
			id=rc.userID,
			firstname=rc.firstname,
			lastname=rc.lastname,
			username=rc.username,
			email=rc.email,
			password=rc.password,
			timezone=rc.timezone
		)

		relocate( "HomePage/index?userID=" & rc.userID);
		event.setLayout("Home")
	}
}
