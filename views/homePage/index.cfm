<cfoutput>

<!--- Information about signed in user --->
<div class="container-fluid bg-primary bg-gradient">
    <div class="jumbotron jumbotron-fluid p-4">
        <div class="container">
            <div class="d-flex justify-content-around align-items-center">
                <div>
                    <h1 class="display-4 ">#prc.userData.firstname#  #prc.userData.lastname#</h1>
                    <p class="lead" id="username">@#prc.userData.username#</p>
                </div>
                <img src="/includes/images/profilePic.jpg" class="rounded-circle profilePicture" alt="Profile Picture"> 
            </div>
            
        </div>
    </div>
</div> <!--- container fluid --->

<!--- Message entry container --->
<div class="container-fluid bg-info mt-1">
    <form>
        <div class="form-group">
            <textarea 
                class="form-control textAreaNoStyling text-dark" 
                id="messageEntryArea" 
                rows="3"
                maxLength="140"
                placeholder="Let people know what you want to say!"
            ></textarea>
        </div>
    </form>
</div>

<!--- Message submission --->
<div class="container-fluid bg-info mt-1 text-center">
    <button role="button" class="btn btn-info btn-sm text-dark" id="sendMessage">
        Send Message
    </button>
</div>

<!--- Message feed container  --->
<cfloop query="#prc.messageData#">
    <div class="container-fluid mt-2 bg-primary d-flex p-2 align-items-start w-100">
        <img src="/includes/images/profilePic.jpg" class="rounded-circle profilePicture" alt="Profile Picture"> 
        <div class="w-100" style="margin-left: 2rem">
            <div class="d-flex justify-content-between align-items">
                <p>#username#</p>
                <p>#timestap#</p>
            </div>
            #characters#
            
            <div class="d-flex justify-content-end">
                <cfif #userID# == #prc.userData.id#> 
                    <!--- Store the message id so delete button knows which comment to delete. --->
                    <!--- TODO: This smells really bad. --->
                    <button id="messageID#messageID#" class="btn btn-sm btn-danger deleteMessageButton">Delete Message</button> 
                </cfif> 
                <button id="viewComment" class="btn btn-sm btn-primary">View Comments</button>
                <button id="writeComment" class="btn btn-sm btn-primary">Write Comment</button>
               
            </div>
            <!--- Write comment section, hidden by default, toggled by the 'writeComment' button --->
            <form id="commentForm" style="display:none">
                <div class="form-group">
                    <textarea 
                        class="form-control text-light mt-2 mb-2" 
                        id="commentEntryArea" 
                        rows="3"
                        maxLength="140"
                        placeholder="Comment something here..."
                    ></textarea>
                </div>
                <button type="button" id="postComment" class="btn btn-sm btn-primary d-block" style="margin-left: auto">Post Comment</button>
            </form>
        </div>
    </div>
</cfloop>







</cfoutput>