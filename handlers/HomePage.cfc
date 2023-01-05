
component {

// Inject the model
property name="userModel" inject="UserModel";


/**
* index
*/
function index( event, rc, prc ){
	
	// lets param a userId in the rc
	event.paramValue("userID", "")

	var userQuery = wirebox.getInstance( "userModel" ).getUserByID( id=rc.userID );
	
	// save the data to be displayed on the home screen
	prc.userData = QueryGetRow(userQuery, 1)

	// Get and save the message data to the prc
	prc.messageData = wirebox.getInstance( "userModel" ).getMessages();
	
	// Get all comments for each messages and store in a struct: 
	var commentsForEachMessage = StructNew()

	for ( var message in prc.messageData ) {
		var messageID = message["messageID"]
		var comments = wirebox.getInstance( "userModel" ).getComments( messageID=messageID );
		commentsForEachMessage[messageID] = comments
	}

	prc.comments = commentsForEachMessage
	/* 
		{ 
			messageID_1: { QUERY },
			messageID_2: { QUERY },
			.....
			messageID_10: { QUERY }
		} 
	*/

	event.setView( "HomePage/index" );
	event.setLayout("Home")
	
}

/**
* Post message
*/
function postMessage( event, rc, prc ){
	// lets param a userId in the rc
	event.paramValue("userID", "")
	event.paramValue("username", "")

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

	if (!len(rc.password)){
		event.renderData( type="json", data={"Error": "Password cannot be blank."}, statusCode=404 );
		return
	}

	// Get the user's current information
	var currentUserQuery = wirebox.getInstance( "userModel" ).getUserByID( rc.userID )
	var previousInfo = QueryGetRow(currentUserQuery, 1)

	// Check to see if user with this email already exist...
	var updatedEmailQuery = wirebox.getInstance( "userModel" ).getUserByEmail( rc.email )

	// ... and make sure that they didnt change their email to an email that another user is already using.
	var previousEmail = previousInfo["email"]
	var updatedEmail = updatedEmailQuery["email"]

	if (updatedEmailQuery.recordcount == 1 AND previousEmail != updatedEmail) {
		event.renderData( type="json", data={"Error": "User with this email already exists."}, statusCode=403 );
		return
	}

	// Update the user
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

/**
* Upload picture
*/
function saveProfilePicture( event, rc, prc ){
	event.paramValue("userID", "")
	var profilePic = rc.profilePic
	var destination = expandPath("/includes/images/profilePictures")


	var uploadResults = FileUpload(
		#destination#,
		"profilePic",
		"image/png, image/webp, image/jpeg",
		"MakeUnique"
	)

	writeDump(uploadResults.serverfile)
	writeDump(rc.form)


	relocate( "HomePage/index?userID=" & rc.userID);
	event.setLayout("Home")
}

/**
* Add picture to user
*/

}
