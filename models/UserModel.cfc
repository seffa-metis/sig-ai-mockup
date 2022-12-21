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
    public query function getUser ( required string email ) {
        var getUser = new Query();
		getUser.setDatasource("CFSQLTraining");
		getUser.setName("getUser");
        getUser.setSQL(
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
        getUser.addParam( name="email", value=ARGUMENTS.email)
        var userQuery = getUser.execute().getResult()
        return userQuery
    }

    // Updates a row with a given email
    public void function updateEmployee( 
        required string firstName,
        required string lastName,
        required string address,
        required string email,
        required string phoneNumber
    ) {
        var updateQuery = new Query();
		updateQuery.setDatasource("CFSQLTraining");
		updateQuery.setName("updateEmployee");
        updateQuery.setSQL(
            " 
            UPDATE [CFSQLTraining].[dbo].[Employees]
            SET 
                firstname = ( :firstName ),
                lastname =  ( :lastName ),
                address =  ( :address ) ,
                phone =  ( :phoneNumber )
            WHERE email = ( :email )
            " 
        )
        updateQuery.addParam( name="firstName", value=ARGUMENTS.firstName)
        updateQuery.addParam( name="lastName", value=ARGUMENTS.lastName)
        updateQuery.addParam( name="address", value=ARGUMENTS.address)
        updateQuery.addParam( name="email", value=ARGUMENTS.email)
        updateQuery.addParam( name="phoneNumber", value=ARGUMENTS.phoneNumber)
		updateQuery.execute()
    }
    
    // Reads all employee data
    public query function readEmployeeData() {
		var query = new Query();;
		query.setDatasource("CFSQLTraining");
		query.setName("getEmployees");
		var result = query.execute(
			sql = 
                "
				SELECT
					[firstname],
					[lastname],
					[address],
					[email],
					[phone]
				FROM [CFSQLTraining].[dbo].[Employees]
			    "
		)
        return result.getResult()
    }

    // Deletes a row with the given email
    public void function deleteEmployee( required string email ) {
		var deleteQuery = new Query();;
		deleteQuery.setDatasource("CFSQLTraining");
		deleteQuery.setName("deleteEmployee");
        deleteQuery.setSQL(
            " DELETE FROM [CFSQLTraining].[dbo].[Employees]
            WHERE email = ( :email ) " 
        )
        deleteQuery.addParam( name="email", value=ARGUMENTS.email)
		deleteQuery.execute()
    }
}