$( document ).ready(function() {


/*
Sign-in form submission
*/
$("#signIn_form").on("submit", (event) => {

    // TODO: not sure why things are getting submnitted twice when I dont have these?
    event.preventDefault();
    event.stopImmediatePropagation();

    $.ajax({
        url: "http://127.0.0.1:55968/Main/signIn",
        type: "post",
        contentType: "application/json",
        data: JSON.stringify({
            "email": $("#signIn_form_email").val(),
            "password": $("#signIn_form_password").val(),
        }),
        success: function( userID ) { 
            // Redirect to the home page
            alert( "Sign in successful for user with id " + userID ) 
            localStorage.setItem("userID", userID)
            const url = "http://127.0.0.1:55968/HomePage/index?userID=" + userID
            $(location).attr('href',url);
        },
        error: function(jqXHR) {

            // TODO: Is this the correct way to handle error responses?
            if (jqXHR.status == 403) {
                alert( "A user with this email does not exist." ) 
            } else if (jqXHR.status == 404) {
                alert("This email was found but the password did not match.")
            }
        },
    })
})

/*
Sign-up form submission
*/
$("#signUp_form").on("submit", (event) => {

    // TODO: not sure why things are getting submnitted twice when I dont have these?
    event.preventDefault();
    event.stopImmediatePropagation();

    $.ajax({
        url: "http://127.0.0.1:55968/Main/createUser",
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
        success: function() { alert( "User was created. Please sign in." ) },
        error: function(jqXHR) {

            // TODO: Is this the correct way to handle error responses?
            if (jqXHR.status == 403) {
                alert( "A user with this email already exists! " ) 
            }
        },
    })
})

/* 
Message submission
*/
$("#sendMessage").on("click", () => {

    let userID = localStorage.getItem("userID")
    var username = $("#username").text().slice(1)
    console.log(username)

    // TODO: check that the message has text in it
    let message = $("#messageEntryArea").val()

    // if it does call the handler
    $.ajax({
        url: "http://127.0.0.1:55968/HomePage/postMessage?userID=" + String(userID) + "&username=" + username,
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
            if (jqXHR.status == 403) {
                alert( " tough luck your message couldnt be posted " ) 
            } else {
                alert( "there was an unknown error posting this message." )
            }
        },
    })
})

/* 
Delete a message
*/
$(".deleteMessageButton").on("click", (event) => {

    if ( !confirm("Are you sure you want to delete this message?") ) {
        return
    }

    // The id is parsed from the id of the message container which is "messageID<id>"
    const messageID = $(event.currentTarget).closest(".messageContainer").attr("id").substring(9)

    let userID = localStorage.getItem("userID")

     // if it does call the handler
     $.ajax({
        url: "http://127.0.0.1:55968/HomePage/deleteMessage?userID=" + String(userID) + "&messageID=" + String(messageID),
        type: "post",
        contentType: "application/json",
        success: function() { 
            location.reload();
        },
        error: function(jqXHR) {
            alert("Message could not be deleted.")
        },
    })

})

/* 
Post a comment
*/
$(".postComment").on("click", (event) => {

    // Get all url parameters
    let userID = localStorage.getItem("userID")
    var userDisplayName = $("#username").text().slice(1)
    // The id is parsed from the id of the message container which is "messageID<id>"
    var messageID = $(event.currentTarget).closest(".messageContainer").attr("id").substring(9)

    let comment = $(event.currentTarget).parent().find(".commentEntryArea").val()

    // if it does call the handler
    $.ajax({
        url: "http://127.0.0.1:55968/HomePage/postComment?userID=" + String(userID) + "&userDisplayName=" + userDisplayName + "&messageID=" + messageID,
        type: "post",
        contentType: "application/json",
        data: JSON.stringify({
            "comment": comment,
        }),
        success: function() { 
            alert("Comment successfully posted!")
            // location.reload();
        },
        error: function(jqXHR) {
            alert("Comment was not able to be posted!")
        },
    })
})

/* 
Delete a comment
*/
$(".deleteCommentButton").on("click", (event) => {

    if ( !confirm("Are you sure you want to delete this comment?") ) {
        return
    }

    // The id is parsed from the id of the message container which is "messageID<id>"
    const commentID = $(event.currentTarget).closest(".comment").attr("id").substring(9)
 
    let userID = localStorage.getItem("userID")

     // if it does call the handler
     $.ajax({
        url: "http://127.0.0.1:55968/HomePage/deleteComment?userID=" + String(userID) + "&commentID=" + String(commentID),
        type: "post",
        contentType: "application/json",
        success: function() { 
            alert("Comment successfully deleted.")
            location.reload();
        },
        error: function(jqXHR) {
            alert("Comment could not be deleted.")
        },
    })


})


/*
The following functions simply toggle forms and other things 
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

});