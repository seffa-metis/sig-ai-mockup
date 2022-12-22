$( document ).ready(function() {

// Sign in / sign up form animations
$("#signIn_heading").on("click", () => {
    console.log("Clicked")
    if ( $( "#signIn_form" ).first().is( ":hidden" ) ) {
        $( "#signIn_form" ).slideDown( "slow" );
        $( "#signUp_form" ).hide("slow");
    } 
})
$("#signUp_heading").on("click", () => {
    console.log("Clicked")
    if ( $( "#signUp_form" ).first().is( ":hidden" ) ) {
        $( "#signUp_form" ).slideDown( "slow" );
        $( "#signIn_form" ).hide(400);
    } 
})

// Sign in / sign up form submissions
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

// Message submissions
$("#sendMessage").on("click", () => {

    let userID = localStorage.getItem("userID")

    // TODO: check that the message has text in it
    let message = ("#messageEntryArea").val()

    // if it does call the handler
    $.ajax({
        url: "http://127.0.0.1:55968/Home/postMessage?userID=" + userID,
        type: "post",
        contentType: "application/json",
        data: JSON.stringify({
            "message": $("#messageEntryArea").val(),
        }),
        success: function() { 
            alert( "Message was posted!" ) 
        },
        error: function(jqXHR) {

            if (jqXHR.status == 403) {
                alert( "A user with this email already exists! " ) 
            } else {
                alert( "there was an unknown error posting this message." )
            }
        },
    })
})




});