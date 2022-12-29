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
</div>

<!---Edit Profile form, hidden by default --->
<div class="container-fluid p-3 editProfileContainer mt-1" style="display: none">
    <div class="container">
        <h3>Edit Profile</h3>
        <form id="editProfileForm">
            <div class="form-group">
                <label for="editProfileForm_firstname">First Name</label>
                <input required type="text" class="form-control" id="editProfileForm_firstname" >
            </div>
            <div class="form-group">
                <label for="editProfileForm_lastname">Last Name</label>
                <input required type="text" class="form-control" id="editProfileForm_lastname" >
            </div>
            <div class="form-group">
                <label for="editProfileForm_username">Username</label>
                <input required type="text" class="form-control" id="editProfileForm_username" >
            </div>
            <div class="form-group">
                <label for="editProfileForm_email">Email address</label>
                <input required type="email" class="form-control" id="editProfileForm_email" aria-describedby="emailHelp">
            </div>
            <div class="form-group">
                <label for="editProfileForm_password">Password</label>
                <input required type="password" class="form-control" id="editProfileForm_password" >
            </div>
            <div class="form-group">
                <label for="editProfileForm_timezone">Time Zone</label>    
                <select class="form-control form-control-sm" id="editProfileForm_timezone">
                    <option>AST Atlantic</option>
                    <option>EST Eastern</option>
                    <option>CST Central</option>
                    <option>MST Mountain</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary mt-2" id="editProfileSubmissionButton">Submit</button>
        </form>
    </div>
</div>

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

    <!---  Message + picture container    --->
    <div class="container-fluid mt-2 bg-primary d-flex p-2 align-items-start w-100">
        <img src="/includes/images/profilePic.jpg" class="rounded-circle profilePicture" alt="Profile Picture"> 
        <div class="w-100 messageContainer" style="margin-left: 2rem" id="messageID#messageID#">
            <div class="d-flex justify-content-between align-items">
                <p>#username#</p>
                <p>#timestap#</p>
            </div>
            #message#

            <!--- Button Options --->
            <div class="d-flex justify-content-end">
                <cfif #userID# == #prc.userData.id#> 
                    <!--- Store the message id so delete button knows which comment to delete. --->
                    <!--- TODO: This smells really bad. --->
                    <button  class="btn btn-sm btn-danger deleteMessageButton">Delete Message</button> 
                </cfif> 
                <button class="btn btn-sm btn-primary viewComment">View Comments</button>
                <button class="btn btn-sm btn-primary writeComment">Write Comment</button>
            </div>

            <!--- Write new comment section, hidden by default, toggled by the 'writeComment' button --->
            <div id="commentForm" style="display:none">
                <textarea 
                    class="form-control text-light mt-2 mb-2 commentEntryArea" 
                    rows="3"
                    maxLength="140"
                    placeholder="Comment something here..."
                ></textarea>
                <button type="button" class="btn btn-sm btn-primary d-block postComment" style="margin-left: auto">Post Comment</button>
            </div>

            <!--- Generate the comments --->
            <div class="commentContainer" style="display:none">
                <cfloop query="#prc.comments["#messageID#"]#">
                    <cfif len(#comment#)>
                        <div class="comment mt-2 p-2" id="commentID#commentid#">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <p class="mb-0">#userdisplayname#</p>
                                <p class="mb-0">#date#</p>
                            </div>
                            <p class="text-wrap text-break mb-0">#comment#</p>
                            <cfif #commentUserID# == #prc.userData.id#>
                                <button  class="btn btn-sm btn-danger deleteCommentButton d-block" style="margin-left: auto">Delete Comment</button>
                            </cfif>
                        </div>
                    </cfif>
                </cfloop> 
            </div> 


        </div> <!--- Message container --->
    </div> <!--- Message + picture container --->
</cfloop> <!--- Message loop --->


</cfoutput>
