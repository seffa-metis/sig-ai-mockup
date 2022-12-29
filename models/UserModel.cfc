component {
    
/**
* Creates a new User
*/
public void function createUser(
    required string id,
    required string firstname,
    required string lastname,
    required string username,
    required string email,
    required string password,
    required string timezone
) {
    var createQuery = new Query();
    createQuery.setDatasource("CFSQLTraining");
    createQuery.setName("createUser");
    createQuery.setSQL(
        " 
        INSERT INTO [CFSQLTraining].[dbo].[fizzleusers]
        VALUES ( :id, :firstname, :lastname, :email, :username,  :password, :timezone) 
        " 
    )
    createQuery.addParam( name="id", value=ARGUMENTS.id)
    createQuery.addParam( name="firstname", value=ARGUMENTS.firstname)
    createQuery.addParam( name="lastname", value=ARGUMENTS.lastname)
    createQuery.addParam( name="email", value=ARGUMENTS.email)
    createQuery.addParam( name="username", value=ARGUMENTS.username)
    createQuery.addParam( name="password", value=ARGUMENTS.password)
    createQuery.addParam( name="timezone", value=ARGUMENTS.timezone)
    createQuery.execute()
};

/**
* Get a user with a given email
*/
public query function getUserByEmail ( required string email ) {
    var getUserByEmail = new Query();
    getUserByEmail.setDatasource("CFSQLTraining");
    getUserByEmail.setName("getUserByEmail");
    getUserByEmail.setSQL(
        " 
        SELECT 
            [id],
            [firstname],
            [lastname],
            [email],
            [username],
            [password],
            [timezone]
        FROM [CFSQLTraining].[dbo].[fizzleusers]
        WHERE [email] = :email ;
        " 
    )
    getUserByEmail.addParam( name="email", value=ARGUMENTS.email)
    var userQueryEmail = getUserByEmail.execute().getResult()
    return userQueryEmail
}

/**
* Get a user with a given id
*/
public query function getUserByID ( required string id ) {
    var getUserByID = new Query();
    getUserByID.setDatasource("CFSQLTraining");
    getUserByID.setName("getUserByID");
    getUserByID.setSQL(
        " 
        SELECT 
            [id],
            [firstname],
            [lastname],
            [email],
            [username],
            [timezone],
            [password]
        FROM [CFSQLTraining].[dbo].[fizzleusers]
        WHERE [id] = :id ;
        " 
    )
    getUserByID.addParam( name="id", value=ARGUMENTS.id)
    var userQueryID = getUserByID.execute().getResult()
    return userQueryID
}

/**
* Update user
*/
public void function updateUser (
    required string id,
    required string firstname,
    required string lastname,
    required string username,
    required string email,
    required string password,
    required string timezone
) {
    var updateQuery = new Query();
    updateQuery.setDatasource("CFSQLTraining");
    updateQuery.setName("updateUser");
    updateQuery.setSQL(
        " 
        UPDATE [CFSQLTraining].[dbo].[fizzleusers]
        SET
            id = ( :id ), 
            firstname = ( :firstname ), 
            lastname = ( :lastname ), 
            email = ( :email ), 
            username = ( :username ),  
            password = ( :password ), 
            timezone = ( :timezone )
        WHERE id = ( :id )
        " 
    )
    updateQuery.addParam( name="id", value=ARGUMENTS.id)
    updateQuery.addParam( name="firstname", value=ARGUMENTS.firstname)
    updateQuery.addParam( name="lastname", value=ARGUMENTS.lastname)
    updateQuery.addParam( name="email", value=ARGUMENTS.email)
    updateQuery.addParam( name="username", value=ARGUMENTS.username)
    updateQuery.addParam( name="password", value=ARGUMENTS.password)
    updateQuery.addParam( name="timezone", value=ARGUMENTS.timezone)
    updateQuery.execute()
}

/**
* Get messages
*/
public query function getMessages() {

    /* 
    NOTE: This query uses an inner join which only gets posts which are associated with
    users who are also in the user table. Since this database was automatically generated,
    there are lots of posts that were generated that do not match a user in the user table.
    Since that would never happen in a real application, i am only using posts that are properly
    associated with users in the user table ( users created by me, and not auto-generated ).
    */
    
    var getMessages = new Query();
    getMessages.setDatasource("CFSQLTraining");
    getMessages.setName("getMessages");
    getMessages.setSQL(
        " 
        SELECT TOP 10
            fm.username, 
            fm.characters as message,
            FORMAT ( fm.timestap, 'MM-dd-yy' ) as timestap, 
            u.id as userID,
            fm.id as messageID
        FROM CFSQLTraining.dbo.fizzlemessages fm
        INNER JOIN fizzleusers u ON fm.username = u.username
        ORDER BY timestap DESC;
        " 
    )
    var getMessagesQuery = getMessages.execute().getResult()
    return getMessagesQuery
}

/**
* Get comments for a message
*/
public query function getComments( required string messageID ) {
    var getCommentsQuery = new Query();
    getCommentsQuery.setDatasource("CFSQLTraining");
    getCommentsQuery.setName("getComments");
    getCommentsQuery.setSQL(
        " 
        SELECT
            commentid, 
            postid, 
            userid as commentUserID, 
            FORMAT (date, 'MM-dd-yy') as date,
            comment,
            userdisplayname
        FROM CFSQLTraining.dbo.Comments
        WHERE postid = ( :messageID )
        ORDER BY date DESC;
        " 
    )
    getCommentsQuery.addParam( name="messageID", value=ARGUMENTS.messageID)
    var comments = getCommentsQuery.execute().getResult()
    return comments
}

/**
* Delete a message
*/
public void function deleteMessage( required string messageID ) {
    var deleteMessageQuery = new Query();
    deleteMessageQuery.setDatasource("CFSQLTraining");
    deleteMessageQuery.setName("deleteMessageQuery");
    deleteMessageQuery.setSQL(
        " 
        DELETE FROM [CFSQLTraining].[dbo].[fizzlemessages]
        WHERE fizzlemessages.ID = ( :messageID )
        " 
    )
    deleteMessageQuery.addParam( name="messageID", value=ARGUMENTS.messageID)
    deleteMessageQuery.execute()
}

/**
* Delete a comment
*/
public void function deleteComment( required string commentID ) {
    var deleteCommentQuery = new Query();
    deleteCommentQuery.setDatasource("CFSQLTraining");
    deleteCommentQuery.setName("deleteCommentQuery");
    deleteCommentQuery.setSQL(
        " 
        DELETE FROM [CFSQLTraining].[dbo].[Comments]
        WHERE Comments.commentid = ( :commentID )
        " 
    )
    deleteCommentQuery.addParam( name="commentID", value=ARGUMENTS.commentID)
    deleteCommentQuery.execute()
}


/**
* Post a comment
*/
public void function postComment( 
    required string messageID,
    required string userID,
    required string comment,
    required string userdisplayname
) {
    var postCommentQuery = new Query();
    postCommentQuery.setDatasource("CFSQLTraining");
    postCommentQuery.setName("postComment");
    postCommentQuery.setSQL(
        " 
        INSERT INTO [CFSQLTraining].[dbo].[Comments]
        VALUES (:messageID, :userID, GETDATE(), :comment,  :userdisplayname) 
        " 
    )
    postCommentQuery.addParam( name="messageID", value=ARGUMENTS.messageID)
    postCommentQuery.addParam( name="userID", value=ARGUMENTS.userID)
    postCommentQuery.addParam( name="comment", value=ARGUMENTS.comment)
    postCommentQuery.addParam( name="userdisplayname", value=ARGUMENTS.userdisplayname)
    postCommentQuery.execute()
}


/**
* Post a new message
*/
public void function postMessage( 
    required string id, 
    required string username, 
    required string message, 
    required string timestap,
    required string latitude,
    required string longitude 
    )  {
    var postMessage = new Query();
    postMessage.setDatasource("CFSQLTraining");
    postMessage.setName("postMessage");
    postMessage.setSQL(
        " 
        INSERT INTO [CFSQLTraining].[dbo].[fizzlemessages]
        VALUES (
            :id,
            :username,
            :characters,
            GETDATE(),
            :latitude,
            :longitude
            );
        " 
    )
    postMessage.addParam( name="id", value=ARGUMENTS.id)
    postMessage.addParam( name="username", value=ARGUMENTS.username)
    postMessage.addParam( name="characters", value=ARGUMENTS.message)
    postMessage.addParam( name="timestap", value=ARGUMENTS.timestap)
    postMessage.addParam( name="latitude", value=ARGUMENTS.latitude)
    postMessage.addParam( name="longitude", value=ARGUMENTS.longitude)
    postMessage.execute()
};

/* 
NOTE: About the next two functions. The database we were given should have
autoincremented IDs but that was not setup correctly. So for this exercise I am 
just finding the highest id that is in there and adding +1 to it so I can insert data
which requires IDs.
*/ 

/**
* Gets the row with the highest user id so we can generate a new ID
*/
public query function getHighestUserID () {
    var getHighestUserID = new Query();
    getHighestUserID.setDatasource("CFSQLTraining");
    getHighestUserID.setName("getHighestUserID");
    getHighestUserID.setSQL(
        " 
        SELECT TOP 1 [id]
        FROM [CFSQLTraining].[dbo].[fizzleusers]
        ORDER BY [id] DESC;
        " 
    )
    var idQuery = getHighestUserID.execute().getResult()
    return idQuery
}

/**
* Gets the row with the highest message id so we can generate a new ID
*/
public query function getHighestMessageID () {
    var getHighestMessageID = new Query();
    getHighestMessageID.setDatasource("CFSQLTraining");
    getHighestMessageID.setName("getHighestMessageID");
    getHighestMessageID.setSQL(
        " 
        SELECT TOP 1 [id]
        FROM [CFSQLTraining].[dbo].[fizzlemessages]
        ORDER BY [id] DESC;
        " 
    )
    var idQuery = getHighestMessageID.execute().getResult()
    return idQuery
}

}