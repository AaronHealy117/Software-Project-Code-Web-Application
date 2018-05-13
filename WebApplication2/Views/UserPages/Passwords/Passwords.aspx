<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Passwords.aspx.cs" Inherits="WebApplication2.Views.UserPages.Passwords.Passwords" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- 
        Code Modified from:
        Title: Add Firebase to your JavaScript Project
        Author: Google
        Availability: https://firebase.google.com/docs/web/setup?authuser=0

        Code Modified from:
        Title: Click table row and get value of all cells
        Author: Khanh Tran
        Availability: https://stackoverflow.com/questions/16426163/click-table-row-and-get-value-of-all-cells

        Code Modified from:
        Title: Read and Write Data on the Web
        Author: Google
        Availability: https://firebase.google.com/docs/database/web/read-and-write?authuser=0

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
                <h4 class="text-center">Your Passwords</h4>
                <br />
                <br />
                <p id="tester"></p>

                <table class="table table-hover" id="passwordList" onclick="getRow()">
                    <thead>
                        <tr>
                            <th scope="col">Password Name</th>
                            <th scope="col">Password</th>
                            <th scope="col" hidden="hidden">pin</th>
                        </tr>
                    </thead>
                    <tbody id="passwordTable">
                    </tbody>

                </table>
            </div>
        </div>
    </div>

    <!-- decrypt a password-->

    <div class="container" style="margin-bottom: 150px;">
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <h4 class="text-center">Decrypt a Password</h4>
                <br />
                <br />

                <asp:Label ID="passwordName" runat="server" Text=""></asp:Label>
                <br />
                <br />
                <asp:TextBox ID="Text1" runat="server" BorderStyle="None"  BackColor="Transparent" Width="100%" style="display:none;" ></asp:TextBox>

                <asp:TextBox ID="passwordTxt" runat="server" BorderStyle="None" BackColor="Transparent" Width="100%"></asp:TextBox>
                <br />
                <br />
                <asp:TextBox ID="pincodeInput" runat="server" placeholder="Enter Pincode" BorderStyle="Solid" BorderColor="Black" Width="100%" Wrap="True" MaxLength="6"></asp:TextBox>
                <br />

                <br />
                <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" OnClick="decryptBtn_Click" Text="Decrypt" />
                <br />
                <br />
                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            </div>
           
        </div>
    </div>

    <!-- encrypt a new password -->

    <div class="container" style="margin-top: 100px; margin-bottom: 150px;">
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <h4 class="text-center">Add A New Password</h4>
                <br />
                <p class="text-center">Fill in each input and then encrypt and upload</p>
                <br />

                <asp:TextBox ID="passName" runat="server" placeholder="Enter Password Name" BorderStyle="Solid" BorderColor="Black" Width="100%" Wrap="True" MaxLength="20"></asp:TextBox>
                <br />
                <br />
                <asp:TextBox ID="passText" runat="server" placeholder="Enter Password" BorderStyle="Solid" BorderColor="Black" Width="100%" Wrap="True" MaxLength="20"></asp:TextBox>
                <br />
                <br />
                <asp:TextBox ID="pinText" runat="server" placeholder="Enter 6 Digit Pincode" BorderStyle="Solid" BorderColor="Black" Width="100%" Wrap="True" MaxLength="6"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" display="Dynamic" ControlToValidate="pinText" ErrorMessage="Pin Code must be 6 digits."  ValidationExpression="[^\s]{6,}" />
                <br />
                <br />
                <asp:Button ID="encryptBtn" runat="server" CssClass="btn btn-primary" Text="Encrypt" OnClick="encryptBtn_Click" />

                <button type="button" class="btn btn-primary" onclick="writeUserData()">Upload</button>
                <br />
                <br />
                <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
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

        //method to upload data to database
        function writeUserData() {

            //get the current logged in user ID 
            var user = firebase.auth().currentUser;
            var id = user.uid;

            //get the user inputs
            var PasswordName = document.getElementById('<%=passName.ClientID%>').value;
            console.log(PasswordName);
            var PasswordText = document.getElementById('<%=passText.ClientID%>').value;
            console.log(PasswordText);
            var Pincode = document.getElementById('<%=pinText.ClientID%>').value;
            console.log(Pincode);
            document.getElementById('<%=Label2.ClientID%>').value;

            //input validation to kmake sure the inputs arent null
            if (PasswordName == "") {
                document.getElementById('<%=Label2.ClientID%>').textContent = "Please enter password name";
            }
            if (PasswordText == "") {
                document.getElementById('<%=Label2.ClientID%>').textContent = "Please enter password";
            }
            if (Pincode == "") {
                document.getElementById('<%=Label2.ClientID%>').textContent = "Please enter a 6 digit pin code";
            }

            //upload the password name, encrypted password and hashed pincode to the firebase database
            var database = firebase.database().ref('/Passwords/' + id).push({
                "PasswordName" : PasswordName,
                "PasswordText" : PasswordText,
                "PinCode" : Pincode
            });

            //clear inputs
            document.getElementById('<%=passName.ClientID%>').value = "";
            document.getElementById('<%=passText.ClientID%>').value = "";
            document.getElementById('<%=pinText.ClientID%>').value = "";

            //show success message
            document.getElementById('<%=Label2.ClientID%>').value = "Encryption and Upload Successful!";

        }

        </script>

    
        <script type="text/javascript">

            //get the password table
            var table = document.getElementById("passwordtable ");
            //get the current logged in user account
            var user = firebase.auth().currentUser;
            //firebase auth check
            firebase.auth().onAuthStateChanged(function (user) {

                //if there is a user logged in 
                if (user) {

                    //get the user ID
                    var id = user.uid;
                    //get the reference to the database table
                    var database = firebase.database().ref().child("Passwords").child(id);

                    //display the users passwords in the table
                    database.on("child_added", snap => {
                        var name = snap.child("PasswordName").val();
                        var pass = snap.child("PasswordText").val();
                        var pin = snap.child("PinCode").val();
                        
                        $("#passwordTable").append("<tr><td>" + name + "</td><td>" + pass + "</td><td>" + pin + "</td></tr>");

                        $('#passwordTable tr > *:nth-child(3)').hide();
                    });
                }

            });

            //method which takes the data from the row the user clicks on
            function getRow() {
            //checks that the table isnt empty
                if (document.getElementById("passwordList") != null) {

                     //get the table
                var table = document.getElementById("passwordList");
                var rows = table.getElementsByTagName('tr');

                var name = '';
                var pass = '';
                var pin = '';

                    //for method to get all the data from the table row
                for (var i = 1; i < rows.length; i++) {

                    rows[i].i = i;
                    rows[i].onclick = function () {

                        //get the data from the first, third and fourth cell in the row that was clicked on
                        name = table.rows[this.i].cells[0].innerHTML;
                        pass = table.rows[this.i].cells[1].innerHTML;
                        pin = table.rows[this.i].cells[2].innerHTML;

                        //display the data in the decrypt div 
                        document.getElementById('<%=passwordName.ClientID%>').textContent = name;
                        document.getElementById('<%=passwordTxt.ClientID%>').value = pass;
                        document.getElementById('<%=Text1.ClientID%>').value = pin;

                        

                    };
                }
            }
        }


    </script>

</asp:Content>
