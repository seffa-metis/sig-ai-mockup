component {

    // Creates a new User
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

    // Get a user with a given email
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

    // Get a user with a given id
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
                [timezone]
            FROM [CFSQLTraining].[dbo].[fizzleusers]
            WHERE [id] = :id ;
            " 
        )
        getUserByID.addParam( name="id", value=ARGUMENTS.id)
        var userQueryID = getUserByID.execute().getResult()
        return userQueryID
    }

    // Get messages
    public query function getMessages( required string quantity ) {
        var getMessages = new Query();
		getMessages.setDatasource("CFSQLTraining");
		getMessages.setName("getMessages");
        getMessages.setSQL(
            " 
            SELECT TOP 10
                [id],
                [username],
                [characters],
                [timestap],
                [latitude],
                [longitude]
            FROM [CFSQLTraining].[dbo].[fizzlemessages]
            ORDER BY [timestap] DESC
            " 
        )
        getMessages.addParam( name="quantity", value=ARGUMENTS.quantity)
        var getMessagesQuery = getMessages.execute().getResult()
        return getMessagesQuery
    }

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
                :timestap,
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

    // Gets the row with the highest id so we can generate a new ID
    public query function getHighestID () {
        var getID = new Query();
		getID.setDatasource("CFSQLTraining");
		getID.setName("getID");
        getID.setSQL(
            " 
            SELECT TOP 1 
                [id],
                [firstname],
                [lastname],
                [email],
                [username],
                [password],
                [timezone]
            FROM [CFSQLTraining].[dbo].[fizzleusers]
            ORDER BY [id] DESC;
            " 
        )
        var idQuery = getID.execute().getResult()
        return idQuery
    }

    // Updates a row with a given email
    // public void function updateEmployee( 
    //     required string firstName,
    //     required string lastName,
    //     required string address,
    //     required string email,
    //     required string phoneNumber
    // ) {
    //     var updateQuery = new Query();
	// 	updateQuery.setDatasource("CFSQLTraining");
	// 	updateQuery.setName("updateEmployee");
    //     updateQuery.setSQL(
    //         " 
    //         UPDATE [CFSQLTraining].[dbo].[Employees]
    //         SET 
    //             firstname = ( :firstName ),
    //             lastname =  ( :lastName ),
    //             address =  ( :address ) ,
    //             phone =  ( :phoneNumber )
    //         WHERE email = ( :email )
    //         " 
    //     )
    //     updateQuery.addParam( name="firstName", value=ARGUMENTS.firstName)
    //     updateQuery.addParam( name="lastName", value=ARGUMENTS.lastName)
    //     updateQuery.addParam( name="address", value=ARGUMENTS.address)
    //     updateQuery.addParam( name="email", value=ARGUMENTS.email)
    //     updateQuery.addParam( name="phoneNumber", value=ARGUMENTS.phoneNumber)
	// 	updateQuery.execute()
    // }
    
    // Reads all employee data
    // public query function readEmployeeData() {
	// 	var query = new Query();;
	// 	query.setDatasource("CFSQLTraining");
	// 	query.setName("getEmployees");
	// 	var result = query.execute(
	// 		sql = 
    //             "
	// 			SELECT
	// 				[firstname],
	// 				[lastname],
	// 				[address],
	// 				[email],
	// 				[phone]
	// 			FROM [CFSQLTraining].[dbo].[Employees]
	// 		    "
	// 	)
    //     return result.getResult()
    // }

    // Deletes a row with the given email
    // public void function deleteEmployee( required string email ) {
	// 	var deleteQuery = new Query();;
	// 	deleteQuery.setDatasource("CFSQLTraining");
	// 	deleteQuery.setName("deleteEmployee");
    //     deleteQuery.setSQL(
    //         " DELETE FROM [CFSQLTraining].[dbo].[Employees]
    //         WHERE email = ( :email ) " 
    //     )
    //     deleteQuery.addParam( name="email", value=ARGUMENTS.email)
	// 	deleteQuery.execute()
    // }
}