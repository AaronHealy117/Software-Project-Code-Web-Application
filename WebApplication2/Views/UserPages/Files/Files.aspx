<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Files.aspx.cs" Inherits="WebApplication2.Views.UserPages.Files.Files" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- 
        Code Modified from:
        Title: Add Firebase to your JavaScript Project
        Author: Google
        Availability: https://firebase.google.com/docs/web/setup?authuser=0

        Code Modified from:
        Title: Work with Lists of Data on the Web
        Author: Google
        Availability: https://firebase.google.com/docs/database/web/lists-of-data?authuser=0

        Code Modified from:
        Title: Data Tables and Firebase Web
        Author: Google
        Availability: https://stackoverflow.com/questions/42451559/data-tables-and-firebase-web

        -->


    <div class="container" style="margin-top: 150px; margin-bottom: 150px;">
        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10">
                <h4 class="text-center">Your Files</h4>
                <br />
                <br />
                <p id="tester"></p>

                <table class="table table-hover" id="passwordList" onclick="getRow()">
                    <thead>
                        <tr>
                            <th scope="col">File Name</th>
                            <th scope="col">File Description</th>
                        </tr>
                    </thead>
                    <tbody id="passwordTable">
                    </tbody>

                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.firebase.com/js/client/2.4.2/firebase.js"></script>
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

    <script type="text/javascript">

        //get the table
        var table = document.getElementById("passwordtable");
        //get the current user
        var user = firebase.auth().currentUser;

        //check is the user is logged in
        firebase.auth().onAuthStateChanged(function (user) {
            //if there is a user logged in
            if (user) {

                //get the user ID
                var id = user.uid;
                //create reference to the database where the file is stored
                var database = firebase.database().ref().child("Files").child(id);

                //display the data in the table
                database.on("child_added", snap => {
                    var name = snap.child("FileName").val();
                    var desc = snap.child("FileDesc").val();
                    
                    $("#passwordTable").append("<tr><td>" + name + "</td><td>" + desc + "</td></tr>");
                });
            }

        });

    </script>

</asp:Content>
