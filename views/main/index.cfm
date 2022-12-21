<!--- SIGN UP / SIGN IN PAGE --->

<cfoutput>

<div class="container">

    <!--- Sign In Form --->
    <h2 id="signIn_heading" role="button" class="mb-2">Sign In</h2>
    <form id="signIn_form" class="mb-5 bg-light">
        <div class="form-group">
            <label for="signIn_form_email">Email address</label>
            <input type="email" class="form-control" id="signIn_form_email" aria-describedby="emailHelp" placeholder="Enter email">
        </div>
        <div class="form-group">
            <label for="signIn_form_password">Password</label>
            <input type="password" class="form-control" id="signIn_form_password" placeholder="Password">
        </div>
        <button type="submit" class="btn btn-primary  mt-2">Submit</button>
    </form>

    <!--- Sign Up Form --->
    <h2 id="signUp_heading" role="button" class="mb-2 bg-light">Sign Up</h2>
    <form id="signUp_form" style="display:none">
        <div class="form-group">
            <label for="signUp_form_email">Email address</label>
            <input required type="email" class="form-control" id="signUp_form_email" aria-describedby="emailHelp" placeholder="Enter email">
            <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
        </div>
        <div class="form-group">
            <label for="signUp_form_password">Password</label>
            <input required type="password" class="form-control" id="signUp_form_password" placeholder="Password">
        </div>
        <div class="form-group">
            <label for="signUp_form_username">Username</label>
            <input type="password" class="form-control" id="signUp_form_username" placeholder="Password">
        </div>
        <button type="submit" class="btn btn-primary mt-2">Submit</button>
    </form>
</div>  <!--- Container --->

</cfoutput>
