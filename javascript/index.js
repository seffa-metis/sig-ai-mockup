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

    // Sign in / sign up form submittions
    $("#signIn_form").on("submit", () => {
        $.ajax({
            url: "http://127.0.0.1:52504/signIn",
            type: "post",
            contentType: "application/json",
            data: JSON.stringify({
                "email": $("#signIn_form_email").val(),
                "password": $("#signIn_form_password").val(),
            }),
            success: function() { alert( "Sign in successful" ) },
            error: function() { 
                alert( "Could not sign in. Please check credentials." ) 
                // TODO: handle 403 user not found and 400 password doesnt match errors
            }
        })
    })
    $("#signUp_form").on("submit", () => {
        $.ajax({
            url: "http://127.0.0.1:52504/createUser",
            type: "post",
            contentType: "application/json",
            data: JSON.stringify({
                "email": $("#signUp_form_email").val(),
                "password": $("#signUp_form_password").val(),
                "username": $("#signUp_form_username").val(),
            }),
            success: function() { alert( "User was created. Please sign in." ) },
            error: function() { alert( "There was a problem creating this account." ) }
        })
    })




  });