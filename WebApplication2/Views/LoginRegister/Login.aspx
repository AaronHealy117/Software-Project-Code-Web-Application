<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication2.Views.LoginRegister.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- 
        Code Modified from:
        Title: Authenticate with Firebase using Password-Based Accounts on Android
        Author: Google
        Availability: https://firebase.google.com/docs/auth/android/password-auth?authuser=0

        Code Modified from:
        Title: Add Firebase to your JavaScript Project
        Author: Google
        Availability: https://firebase.google.com/docs/web/setup?authuser=0

        -->


    
    <!-- login -->
    <div class="container" id="loginDiv" style="margin-top:150px; margin-bottom:150px;">
        <div class="row">
            <div class="col-md-3"></div>

            <div class="col-md-6">
                <h2 class="text-center">Login</h2>

                <label>Email address</label>
                <input type="email" class="form-control" id="email" placeholder="Enter email">
                <asp:Label ID="emailError" runat="server" ForeColor="#D24958"></asp:Label>
                <br />
                <br />

                <label>Password</label>
                <input type="password" class="form-control" id="password" placeholder="Password">
                <asp:Label ID="passwordError" runat="server" ForeColor="#D24958" ></asp:Label>
                
                <br />
                <br />
                <button type="button" class="btn btn-primary" onclick="SignIn()">Login</button>
                <button type="button" class="btn btn-primary" style="float: right; " onclick="Register()">Register</button>

                <br />
                <br />
                

            </div>
            <div class="col-md-3"></div>
        </div>

    </div>

    <!-- logged in -->
    <div class="container" id="loggedInDiv">
        <div class="row" style="margin-top:200px; margin-bottom:200px;">
            <div class="col-md-4"></div>

            <div class="col-md-4">
                <br />
                <br />
                <h2 class="text-center" id="welcomeText"></h2>
                <br />
                <br />

                <a class="btn btn-primary" style="width:100%;" href="../UserPages/userIndex.aspx" role="button">Go to your home page</a>

            </div>
            <div class="col-md-3"></div>
        </div>

    </div>

    <!-- register -->
    <div class="container" id="RegisterDiv" style="margin-top:200px; margin-bottom:200px;">
        <div class="row">
            <div class="col-md-3"></div>

            <div class="col-md-6">
                <h2 class="text-center">Register A New Account</h2>
                <br />
                <br />

                <label style="color:black;">Full Name</label>
                <asp:TextBox ID="newName" runat="server" class="form-control" placeholder="Enter Full Name"></asp:TextBox>
                <br />

                <label style="color:black;">Email address</label>
                <asp:TextBox ID="newEmail" runat="server" class="form-control" placeholder="Enter Email Address"></asp:TextBox>
                <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="newEmail" ErrorMessage="Invalid Email Format"></asp:RegularExpressionValidator>
                <br />

                <label style="color:black;">Phone Number</label>
                <asp:TextBox ID="newPhone" runat="server" class="form-control" placeholder="Enter Phone Number"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="newPhone" ErrorMessage="Phone Number is required."></asp:RequiredFieldValidator><br />
                <asp:RegularExpressionValidator runat="server" display="Dynamic" ControlToValidate="newPhone" ErrorMessage="Must contain numbers." ValidationExpression="[0-9]+" />
                <br />

                <label style="color:black;">Password</label>
                <asp:TextBox ID="newPassword" type="password" runat="server" class="form-control" placeholder="Enter Password"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" display="Dynamic" ControlToValidate="newPassword" ErrorMessage="Password must contain one special character." ValidationExpression=".*[@#$%^&*/].*" /><br />
                <asp:RegularExpressionValidator runat="server" display="Dynamic" ControlToValidate="newPassword" ErrorMessage="Password must be 12 characters."  ValidationExpression="[^\s]{12,}" />
                <asp:RegularExpressionValidator runat="server" display="Dynamic" ControlToValidate="newPassword" ErrorMessage="Password must contain one number." ValidationExpression="[0-9]" />
                
                <br />
                <label style="color:black;">Confirm Password</label>
                <asp:TextBox ID="newPasswordConfirm" type="password" runat="server" class="form-control" placeholder="Confirm Password"></asp:TextBox>
                <asp:CompareValidator runat=server ControlToValidate="newPassword" ControlToCompare="newPasswordConfirm" ErrorMessage="Passwords do not match." />
                <br />
                <br />

                <button type="button" class="btn btn-primary" onclick="handleRegister()">Register</button>

            </div>
            <div class="col-md-3"></div>
        </div>

    </div>
    <script src="https://www.gstatic.com/firebasejs/4.9.0/firebase.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer></script>

    <script>
        // Initialize Firebase
        var config = {
            apiKey: "AIzaSyBJ161qmpslU7rD-4hdHNMXIzztVIbSJvg",
            authDomain: "softwareproject-b1a79.firebaseapp.com",
            databaseURL: "https://softwareproject-b1a79.firebaseio.com",
            projectId: "softwareproject-b1a79",
            storageBucket: "softwareproject-b1a79.appspot.com",
            messagingSenderId: "271991045716"
        };
        firebase.initializeApp(config);
    </script>

    <script type="text/javascript">

        //sign in method
        function SignIn() {

            //get email and password to var
            var email = document.getElementById('email').value;
            var password = document.getElementById('password').value;

            //input validation to check email and password are not null
            if (email.length < 2) {
                document.getElementById('<%=emailError.ClientID%>').textContent = 'Please enter an email address';
                return;
            }
            if (password.length < 2) {
                document.getElementById('<%=passwordError.ClientID%>').textContent = 'Please enter a password';
                return;
            }

            //javascript firebase sign in method with email and password
            firebase.auth().signInWithEmailAndPassword(email, password).catch(function (error) {
                var errorCode = error.code;
                var errorMessage = error.message;
                //if wrong password show wrong password message
                if (errorCode === 'auth/wrong-password') {
                    //alert('Wrong password.');
                    document.getElementById('<%=passwordError.ClientID%>').textContent = "Email or Password are Incorrect";
                //else if other error show error message
                } else {
                    document.getElementById('<%=passwordError.ClientID%>').textContent = errorMessage;
                }

            });
        }


        // method used to show register form and remove login form
        function Register() {
            document.getElementById('loginDiv').style.display = 'none';
            document.getElementById('loggedInDiv').style.display = 'none';
            document.getElementById('RegisterDiv').style.display = 'block';
        }

        //register method
        function handleRegister() {
            //get the user inputs to var
            var name = document.getElementById('<%=newName.ClientID%>').value;
            var email = document.getElementById('<%=newEmail.ClientID%>').value;
            var phone = document.getElementById('<%=newPhone.ClientID%>').value;
            var password = document.getElementById('<%=newPassword.ClientID%>').value;
            var passwordconfirm = document.getElementById('<%=newPasswordConfirm.ClientID%>').value;

            //input validation to make sure important text fields are not null
            if (email.length = 0) {
                return;
            }
            if (password.length < 12) {
                return;
            }
            if (password != passwordconfirm) {
                return;
            }
            
            //javascript method to register a new account qith email and password
            firebase.auth().createUserWithEmailAndPassword(email, password).catch(function (error) {

                //get error messages
                var errorCode = error.code;
                var errorMessage = error.message;
                //if password too weak show message
                if (errorCode == 'auth/weak-password') {
                    alert('The password is too weak.');
                //else show general error message
                } else {
                    alert(errorMessage);
                }

                //get the new user accounts user ID
                var user = firebase.auth().currentUser;
                var id = user.uid;

                //upload the new account data to the firebase database
                var database = firebase.database().ref('/Users/' + id).push({
                    "UserEmail": email,
                    "UserName": name,
                    "UserPhoneNumber": phone
                });
                

            });

        }
        
        //if the user is already logged in chnage the UI
        function initApp() {

            //get current auth instance data
            firebase.auth().onAuthStateChanged(function (user) {
                //if user is logged in
                if (user) {

                    var email = user.email;

                    //display the user email and new UI
                    document.getElementById('welcomeText').textContent = 'Signed in as ' + email;
                    document.getElementById('loginDiv').style.display = 'none';
                    document.getElementById('RegisterDiv').style.display = 'none';
                    document.getElementById('loggedInDiv').style.display = 'block';
                //if no user logged in show the login form
                } else {
                    document.getElementById('loggedInDiv').style.display = 'none';
                    document.getElementById('RegisterDiv').style.display = 'none';
                }
            });


        }

        //used to load the initApp function when the page loads
        window.onload = function () {
            initApp();
        };
    </script>

</asp:Content>
