<!--- SIGN UP / SIGN IN PAGE --->

<cfoutput>

    <!--- Sign In Form --->
    <div class="container-fluid bg-info form_noStyling p-2">
        <div class="container">
            <h2 id="signIn_heading" role="button" class="mb-2">Sign In</h2>
            <form id="signIn_form" class="mb-5">
                <div class="form-group">
                    <label for="signIn_form_email">Email address</label>
                    <input required type="email" class="form-control" id="signIn_form_email" aria-describedby="emailHelp">
                </div>
                <div class="form-group">
                    <label for="signIn_form_password">Password</label>
                    <input required type="password" class="form-control" id="signIn_form_password">
                </div>
                <button type="submit" class="btn btn-primary  mt-2">Submit</button>
            </form>
        </div>
    </div>

    <!--- Sign Up Form --->
    <div class="container-fluid bg-info form_noStyling p-2">
        <div class="container">
            <h2 id="signUp_heading" role="button" class="mb-2 ">Click to Sign Up</h2>
            <form id="signUp_form" style="display:none">
                <div class="form-group">
                    <label for="signUp_form_firstname">First Name</label>
                    <input required type="text" class="form-control" id="signUp_form_firstname" >
                </div>
                <div class="form-group">
                    <label for="signUp_form_lastname">Last Name</label>
                    <input required type="text" class="form-control" id="signUp_form_lastname" >
                </div>
                <div class="form-group">
                    <label for="signUp_form_username">Username</label>
                    <input required type="text" class="form-control" id="signUp_form_username" >
                </div>
                <div class="form-group">
                    <label for="signUp_form_email">Email address</label>
                    <input required type="email" class="form-control" id="signUp_form_email" aria-describedby="emailHelp">
                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                </div>
                <div class="form-group">
                    <label for="signUp_form_password">Password</label>
                    <input required type="password" class="form-control" id="signUp_form_password" >
                </div>
                <div class="form-group">
                    <label for="signUp_form_timezone">Time Zone</label>    
                    <select class="form-control form-control-sm" id="signUp_form_timezone">
                        <option>AST Atlantic</option>
                        <option>EST Eastern</option>
                        <option>CST Central</option>
                        <option>MST Mountain</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary mt-2">Submit</button>
            </form>
        </div>
    </div>


</cfoutput>
