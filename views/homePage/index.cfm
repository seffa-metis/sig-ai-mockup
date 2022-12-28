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
<cfset visitedMessageIDs = ArrayNew(1)>
<cfloop query="#prc.messageData#">
    <!--- 
        Messages in this query will be in order by mesage ID. There will be duplicate message entries because the query
        also contains all the comments for each message. We must check if a row is a new message by using the visitedMessageIDs array, 
        then add that message and a comment if it has one. When we get to a new row, if its the same message as the last, 
        we dont create a new message, but instead create just new comment for the previous message.
        
        This is currently uses a double for loop but could be reduced to a single iteration if the html was re-structured.
    --->

    <cfset currentMessageID = #messageID#>

    <!---  If the messageID isnt in out list of visited messages...  --->
    <cfif not arrayFind(visitedMessageIDs, currentMessageID)>
        
        <!--- First add it to the visitedMessages array to keep track of it --->
        <!--- TODO: How do i do this with tags? --->
        <cfscript>
            arrayAppend(visitedMessageIDs, currentMessageID);
        </cfscript>

        <!--- Then create a new message --->
        <div class="container-fluid mt-2 bg-primary d-flex p-2 align-items-start w-100">
            <img src="/includes/images/profilePic.jpg" class="rounded-circle profilePicture" alt="Profile Picture"> 
            <div class="w-100 messageContainer" style="margin-left: 2rem" id="messageID#messageID#">
                <div class="d-flex justify-content-between align-items">
                    <p>#messageUsername#</p>
                    <p>#messageDate#</p>
                </div>
                #message#
                <!--- Button Options --->
                <div class="d-flex justify-content-end">
                    <cfif #messageUserID# == #prc.userData.id#> 
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

                <!--- Comment container, hidden by default --->
                <div class="commentContainer" style="display:none">

                    <!--- Loop through the query again, and find comments that match this message and create them.--->
                    <cfloop query="#prc.messageData#">
                        <!--- If this row is a part of the same message, create a comment if its not null. --->
                        <cfif #messageID# == currentMessageID and len(#comment#)>
                            <div class="comment mt-2 p-2" id="commentID#commentid#">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <p class="mb-0">#commentUsername#</p>
                                    <p class="mb-0">#commentDate#</p>
                                </div>
                                <p class="text-wrap text-break mb-0">#comment#</p>
                                <cfif #commentUserID# == #prc.userData.id#>
                                    <button  class="btn btn-sm btn-danger deleteCommentButton d-block" style="margin-left: auto">Delete Comment</button>
                                </cfif>
                            </div>
                        </cfif>
                    </cfloop> <!--- Comment loop --->
                
                </div> <!--- Comment container --->
            </div> <!--- Message container --->
        </div> <!--- Message + picture container --->
    </cfif>

</cfloop> <!--- Message loop --->







</cfoutput>