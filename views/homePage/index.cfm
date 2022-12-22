<cfoutput>

<!--- Show info about signed in user and write new messages --->
<header>
    <div class="container-fluid bg-primary bg-gradient">
        <div class="jumbotron jumbotron-fluid p-4">
            <div class="container">
                <div class="d-flex align-items-center">
                    <h1 class="display-4">#prc.userData.firstname#  #prc.userData.lastname#</h1>
                    <img src="/includes/images/profilePic.jpg" class="rounded-circle profilePicture" alt="Profile Picture"> 
                </div>
                <p class="lead">@#prc.userData.username#</p>
            </div>
        </div>
    </div> <!--- container fluid --->
</header>

<!--- Contains the messages  --->
<main>
    <div class="container-fluid">

    </div> <!--- container fluid --->
</main>




</cfoutput>