<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserIndex.aspx.cs" Inherits="WebApplication2.Views.UserPages.UserIndex" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- 
        Code Modified from:
        Title: Add Firebase to your JavaScript Project
        Author: Google
        Availability: https://firebase.google.com/docs/web/setup?authuser=0

        -->

    <div class="jumbotron" style="background-image: url(../../Images/bg1.jpg); background-attachment: fixed; background-size: cover; height: 700px; width: 100%; margin-top: 0px; margin-bottom: 0px;">
        <div class="container" style="margin-top: 100px;">
            <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-2">
                    <img src="../../Images/main_icon.png" style="height: 130px; width: 130px; margin-top: 130px; float: right;" alt="logo image" />
                </div>
                <div class="col-md-6">
                    <h1 style="color: aliceblue; margin-top: 150px;" class="text-center">Welcome to Kryptium</h1>
                    <br />
                    <h4 style="color: aliceblue;" class="text-center">Let use keep your data secure!</h4>
                </div>
            </div>
        </div>
    </div>

    <br />
    <br />

    <div id="userBox">
        <div class="container">
            <div class="row">
                <div class="col-md-2"></div>
                <div class="col-md-8">
                    <h4 class="text-center">Welcome to Your Home Page</h4>
                    <br />
                    <h4 class="text-center" id="userName"></h4>
                    <br />
                    <br />
                    <p class="text-center">
                        This will change the type of persistence on the specified Auth instance for the currently saved Auth session and
                    apply this type of persistence for future sign-in requests, including sign-in with redirect requests. 
                    This will return a promise that will resolve once the state finishes copying from one type of storage to the other. 
                    </p>
                </div>
                <div class="col-md-2"></div>
            </div>
        </div>

        <br />
        <br />

        <div class="container">
            <div class="row">
                <div class="col-md-2"></div>
                <div class="col-md-3">
                    <a href="Passwords/Passwords.aspx">
                        <img src="../../Images/password.png" alt="password image" style="display: block; margin-left: auto; margin-right: auto; margin-bottom: 25px;">
                        <h4 class="text-center">passwords</h4>
                    </a>
                </div>
                <div class="col-md-2"></div>
                <div class="col-md-3">
                    <a href="Text/TextBlocks.aspx">
                        <img src="../../Images/text.png" alt="password image" style="display: block; margin-left: auto; margin-right: auto; margin-bottom: 25px;">
                        <h4 class="text-center">Text Blocks</h4>
                    </a>
                </div>
            </div>
            <br />
            <br />
            <div class="row">
                <div class="col-md-2"></div>
                <div class="col-md-3">
                    <a href="Images/Images.aspx">
                        <img src="../../Images/image.png" alt="password image" style="display: block; margin-left: auto; margin-right: auto; margin-bottom: 25px;">
                        <h4 class="text-center">Images</h4>
                    </a>
                </div>
                <div class="col-md-2"></div>
                <div class="col-md-3">
                    <a href="Files/Files.aspx">
                        <img src="../../Images/files.png" alt="password image" style="display: block; margin-left: auto; margin-right: auto; margin-bottom: 25px;">
                        <h4 class="text-center">Files</h4>
                    </a>
                </div>
            </div>
        </div>


        <div class="container" style="margin-top: 100px; margin-bottom: 100px;">
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <button class="btn btn-danger" id="quickstart-sign-out" style="width: 100%;" onclick="logout()">Sign out</button>
                    <br />
                    <br />
                    <br />
                </div>
            </div>
        </div>

    </div>

    <div class="container" id="loggedoutBox">
        <div class="row" style="margin-top: 200px; margin-bottom: 200px;">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <h4 class="text-center">You are logged out</h4>
                <br />
                <br />

                <a class="btn btn-primary" style="display: block; margin-left: auto; margin-right: auto;" href="../LoginRegister/Login.aspx" role="button">login</a>
                <br />
                <br />

            </div>
        </div>
    </div>

    <script src="https://www.gstatic.com/firebasejs/4.9.0/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/4.9.0/firebase-auth.js"></script>
    <script src="https://www.gstatic.com/firebasejs/4.9.0/firebase-database.js"></script>
    <script src="https://www.gstatic.com/firebasejs/4.9.0/firebase.js"></script>

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
    <script>

        //function to logout user
        function logout() {
            firebase.auth().signOut();
        }

        //method to change UI based on if there is a user logged in or not
        firebase.auth().onAuthStateChanged(function (user) {
            //if user logged in show user home page
            if (user) {
                var email = user.email;

                document.getElementById('userName').textContent = email;
                document.getElementById('userBox').style.display = 'inline';
                document.getElementById('loggedoutBox').style.display = 'none';
            //if no user logged in, show different UI
            } else {
                document.getElementById('userBox').style.display = 'none';
                document.getElementById('loggedoutBox').style.display = 'inline';
            }
        });

    </script>


</asp:Content>
