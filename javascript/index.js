$( document ).ready(function() {


/**
* Sign-in form submission
*/
$("#signIn_form").on("submit", (event) => {

    // We could change the button to type="button" to prevent the automatic submission but this works
    event.preventDefault();
    event.stopImmediatePropagation();

    $.ajax({
        url: "/Main/signIn",
        type: "post",
        contentType: "application/json",
        data: JSON.stringify({
            "email": $("#signIn_form_email").val(),
            "password": $("#signIn_form_password").val(),
        }),
        success: function( userID ) {
            // Redirect to the home page
            localStorage.setItem("userID", userID)
            const url = "/HomePage/index?userID=" + userID
            $(location).attr('href',url);
        },
        error: function(jqXHR) {
            if (jqXHR.status == 403) {
                alert( "A user with this email does not exist." ) 
            } else if (jqXHR.status == 404) {
                alert( "This email was found but the password did not match." )
            } else {
                alert( "There was an unknown error signing in." )
            }
        },
    })
})

/**
* Sign-up form submission
*/
$("#signUp_form").on("submit", (event) => {

    // We could change the button to type="button" to prevent the automatic submission but this works
    event.preventDefault();
    event.stopImmediatePropagation();

    $.ajax({
        url: "/Main/createUser",
        type: "post",
        contentType: "application/json",
        data: JSON.stringify({
            "email": $("#signUp_form_email").val(),
            "password": $("#signUp_form_password").val(),
            "username": $("#signUp_form_username").val(),
            "firstname": $("#signUp_form_firstname").val(),
            "lastname": $("#signUp_form_lastname").val(),
            "timezone": $("#signUp_form_timezone").val(),
        }),
        success: function() { 
            alert( "User was created. Please sign in." )
            location.reload()
        },
        error: function(jqXHR) {
            if (jqXHR.status == 403) {
                alert( "A user with this email already exists! " ) 
            } else if (jqXHR.status == 404) {
                alert( "Password cannot be blank!" ) 
            } else {
                alert( "There was an unknown error creating this account." )
            }
        }
    })
})

/**
* Message submission
*/
$("#sendMessage").on("click", () => {

    let userID = localStorage.getItem("userID")
    var username = $("#username").text().slice(1)
    let message = $("#messageEntryArea").val()

    if (!message) {
        alert("Message cannot be empty.")
        return
    }

    $.ajax({
        url: "/HomePage/postMessage?userID=" + String(userID) + "&username=" + username,
        type: "post",
        contentType: "application/json",
        data: JSON.stringify({
            "message": $("#messageEntryArea").val(),
        }),
        success: function() { 
            $("#messageEntryArea").val("")
            location.reload();
        },
        error: function(jqXHR) {
                alert( " Message couldnt be posted " ) 
        }
    })
})

/**
* Delete a message
*/
$(".deleteMessageButton").on("click", (event) => {

    if ( !confirm("Are you sure you want to delete this message?") ) {
        return
    }

    // The id is parsed from the id of the message container which is "messageID<id>"
    const messageID = $(event.currentTarget).closest(".messageContainer").attr("id").substring(9)

    let userID = localStorage.getItem("userID")

     $.ajax({
        url: "/HomePage/deleteMessage?userID=" + String(userID) + "&messageID=" + String(messageID),
        type: "post",
        contentType: "application/json",
        success: function() { 
            location.reload();
        },
        error: function(jqXHR) {
            alert("Message could not be deleted.")
        }
    })
})

/**
* Post a comment
*/
$(".postComment").on("click", (event) => {
   
    // Get all url parameters
    let userID = localStorage.getItem("userID")
    var userDisplayName = $("#username").text().slice(1)
    let comment = $(event.currentTarget).parent().find(".commentEntryArea").val()
   
    // The id is parsed from the id of the message container which is "messageID<id>"
    var messageID = $(event.currentTarget).closest(".messageContainer").attr("id").substring(9)

    $.ajax({
        url: "/HomePage/postComment?userID=" + String(userID) + "&userDisplayName=" + userDisplayName + "&messageID=" + messageID,
        type: "post",
        contentType: "application/json",
        data: JSON.stringify({
            "comment": comment,
        }),
        success: function() { 
            location.reload();
        },
        error: function(jqXHR) {
            alert("Comment was not able to be posted!")
        }
    })
})

/** 
* Delete a comment
*/
$(".deleteCommentButton").on("click", (event) => {

    if ( !confirm("Are you sure you want to delete this comment?")) {
        return
    }

    // The id is parsed from the id of the message container which is "messageID<id>"
    const commentID = $(event.currentTarget).closest(".comment").attr("id").substring(9)
 
    let userID = localStorage.getItem("userID")

     $.ajax({
        url: "/HomePage/deleteComment?userID=" + String(userID) + "&commentID=" + String(commentID),
        type: "post",
        contentType: "application/json",
        success: function() { 
            location.reload();
        },
        error: function(jqXHR) {
            alert("Comment could not be deleted.")
        }
    })
})

/** 
* Update profile information
*/
$("#editProfileSubmissionButton").on("click", (event)=> {

    let userID = localStorage.getItem("userID")

    $.ajax({
        url: "/HomePage/updateUser?userID=" + String(userID),
        type: "post",
        contentType: "application/json",
        data: JSON.stringify({
            "email": $("#editProfileForm_email").val(),
            "password": $("#editProfileForm_password").val(),
            "username": $("#editProfileForm_username").val(),
            "firstname": $("#editProfileForm_firstname").val(),
            "lastname": $("#editProfileForm_lastname").val(),
            "timezone": $("#editProfileForm_timezone").val(),
        }),
        success: function(  ) { 
            alert( "Profile information updated!" ) 
            location.reload();
        },
        error: function(jqXHR) {

            if (jqXHR.status == 403) {
                alert( "A user with this email already exists! " ) 
            } else if (jqXHR.status == 404) {
                alert( "Password cannot be blank." )
            } else {
                alert( "Something else went wrong when updated user info. ")
            }
        }
    })
})

/** 
* Sign out
*/
$("#signOutButton").on("click", () => {
    window.localStorage.clear()
    $(location).attr('href', "/");
})

/** 
* Upload photo
*/
$("#edit-pic-form").on("submit", (e) => {
    e.preventDefault();
    let userID = localStorage.getItem("userID")
    console.log($("#edit-pic-form")[0])

    const form = new FormData($("#edit-pic-form")[0]);
    
    $.ajax({
        type: "POST",
        url:"/HomePage/saveProfilePicture?userID=" + String(userID),
        data: form,
        dataType: 'json',
        contentType: false,
        processData: false,
        success: function(  ) { 
            alert( "Profile picture updated!" ) 
            location.reload();
        },
        error: function() {
            alert( "Could not upload photo ")
        }
    })
})


/**
* The following functions toggle elements on and off
*/

// Sign in form animations
$("#signIn_heading").on("click", () => {
    console.log("Clicked")
    if ( $( "#signIn_form" ).first().is( ":hidden" ) ) {
        $( "#signIn_form" ).slideDown( "slow" );
        $( "#signUp_form" ).hide("slow");
    } 
})

// Sign up form animations
$("#signUp_heading").on("click", () => {
    console.log("Clicked")
    if ( $( "#signUp_form" ).first().is( ":hidden" ) ) {
        $( "#signUp_form" ).slideDown( "slow" );
        $( "#signIn_form" ).hide(400);
    } 
})

// Comment writting toggler
$(".writeComment").on("click", (event) => {
    $(event.currentTarget).parent().next().slideToggle()
})

// View Comment
$(".viewComment").on("click", (event) => {
    $(event.currentTarget).closest(".messageContainer").find(".commentContainer").slideToggle()
})

// Edit profile toggler which getrs the users information and pre-fills it
$("#editProfileToggler").on("click", () => {
    let userID = localStorage.getItem("userID")

    $.ajax({
        url: "/HomePage/getUserByID?userID=" + String(userID),
        type: "post",
        contentType: "application/json",
        success: function( userData ) { 

            // populates the table with the user's current information
            $("#editProfileForm_firstname").val(userData["FIRSTNAME"])
            $("#editProfileForm_lastname").val(userData["LASTNAME"])
            $("#editProfileForm_username").val(userData["USERNAME"])
            $("#editProfileForm_email").val(userData["EMAIL"])
            $("#editProfileForm_timezone").val(userData["TIMEZONE"])
            $("#editProfileForm_password").val(userData["PASSWORD"])
            $(".editProfileContainer").slideToggle()
        },
        error: function(jqXHR) {
            alert("User info could not be retrieved.")
        }
    }) 
})

});