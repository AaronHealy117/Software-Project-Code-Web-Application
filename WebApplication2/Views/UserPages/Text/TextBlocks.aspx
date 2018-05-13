<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TextBlocks.aspx.cs" Inherits="WebApplication2.Views.UserPages.Text.TextBlocks" %>

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
                <h4 class="text-center">Your Notes</h4>
                <br />
                <br />
                <p id="tester"></p>
                <table class="table table-hover" id="textList" onclick="getRow()">
                    <thead>
                        <tr>
                            <th scope="col" class="text-center">Text Name</th>
                            <th scope="col" class="text-center" >steg image</th>
                        </tr>
                    </thead>
                    <tbody id="passwordTable" class="text-center">
                        
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <br />
    <br />

    <div class="container" style="margin-bottom: 150px;">
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <h4 class="text-center">Decrypt a Steg Image</h4>
                <br />
                <br />
                <asp:Label ID="textName" runat="server" Text=""></asp:Label>
                <br />
                <br />
                <asp:TextBox ID="pincodeText" runat="server" BorderStyle="None" BackColor="Transparent" Width="100%" style="display:none;"  ></asp:TextBox>
                <br />
                <br />
                <asp:Image ID="stegimage" runat="server" />
                <asp:TextBox ID="urlText" runat="server" BorderStyle="None" BackColor="Transparent" Width="100%"  style="display:none;" ></asp:TextBox>
                <br />
                <br />






                <asp:TextBox ID="pincodeInput" runat="server" placeholder="Enter Pincode" BorderStyle="Solid" BorderColor="Black" Width="100%" Wrap="True" MaxLength="6"></asp:TextBox>
                <br />
                <br />
                <asp:Button ID="DecryptStegBtn" runat="server" CssClass="btn btn-primary" OnClick="DecryptStegBtn_Click" Text="Decrypt" />
                <br />
                <br />
                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
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
        //get the table
        var table = document.getElementById("passwordtable ");
        //get the current user
        var user = firebase.auth().currentUser;

        //check if the user is logged in
        firebase.auth().onAuthStateChanged(function (user) {
            //if there is a user logged in
            if (user) {

                //create refereence to firebase storage
                var storage = firebase.storage();
                //get the user ID
                var id = user.uid;
                //get the reference to the firebase database table where the data is stored
                var database = firebase.database().ref().child("TextBlocks").child(id);

                //display the users data in the table
                database.on("child_added", snap => {
                    var pin = snap.child("PinCode").val();
                    var name = snap.child("TextName").val();
                    var imageURL = snap.child("URL").val();

                    var gitmap = storage.ref().child("Bitmaps").child(id).child(name);

                    gitmap.getDownloadURL().then(function (url) {
                        
                        $("#textList").append("<tr><td>" + name + "</td><td><img src='" + url + "'/></td><td>" + pin + "</td><td>" + url + "</td></tr>");

                        $('#passwordTable tr > *:nth-child(3)').hide();
                        $('#passwordTable tr > *:nth-child(4)').hide();
                    });
                    

                }); 
            }

        });
        

    </script>

    <script type="text/javascript">
        //method which takes the data from the row the user clicks on
        function getRow() {
            //checks that the table isnt empty
            if (document.getElementById("textList") != null) {

                //get the table
                var table = document.getElementById("textList");
                var rows = table.getElementsByTagName('tr');

                var name = '';
                var pass = '';
                var url = '';

                //for method to get all the data from the table row
                for (var i = 1; i < rows.length; i++) {

                    rows[i].i = i;
                    rows[i].onclick = function () {

                        //get the data from the first, third and fourth cell in the row that was clicked on
                        name = table.rows[this.i].cells[0].innerHTML;
                        pin = table.rows[this.i].cells[2].innerHTML;
                        url = table.rows[this.i].cells[3].textContent;

                        //display the data in the decrypt div 
                        document.getElementById('<%=textName.ClientID%>').textContent = name;
                        document.getElementById('<%=pincodeText.ClientID%>').value = pin;
                        document.getElementById('<%=stegimage.ClientID%>').setAttribute('src', url);
                        document.getElementById('<%=urlText.ClientID%>').value = url;

                        
                    };
                }
            }
        }
    </script>

</asp:Content>
