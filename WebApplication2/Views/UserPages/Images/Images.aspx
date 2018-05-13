<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Images.aspx.cs" Inherits="WebApplication2.Views.UserPages.Images.Images" %>

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
                <h4 class="text-center">Your Images</h4>
                <br />
                <br />
                
                <table class="table table-hover" id="imageList" onclick="getRow()">
                    <thead>
                        <tr>
                            <th scope="col">Image Name</th>
                            <th scope="col">Description</th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody id="ImageTable">
                    </tbody>

                </table>


            </div>
        </div>
    </div>

    <!-- decrypt an image-->

    <div class="container" style="margin-bottom: 150px;">
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <h4 class="text-center">Decrypt an Image</h4>
                <br />
                <br />
                <asp:TextBox ID="imageName" runat="server" BorderStyle="None" BackColor="Transparent" Width="100%"></asp:TextBox>
                <br />
                <br />
                <asp:TextBox ID="StoredPinCode" runat="server" BorderStyle="None" BackColor="Transparent" Width="100%" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="ImageURL" runat="server" BorderStyle="None" BackColor="Transparent" Width="100%" Style="display: none;"></asp:TextBox>
                <br />
                <br />
                <asp:TextBox ID="pincodeInput" runat="server" placeholder="Enter Pincode" BorderStyle="Solid" BorderColor="Black" Width="100%" Wrap="True" MaxLength="6"></asp:TextBox>
                <br />
                <br />
                <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="Decrypt" OnClick="Button1_Click" />
                <br />
                <br />
                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            </div>

        </div>
    </div>

    <!-- encrypt a new image -->

    <div class="container" style="margin-top: 100px; margin-bottom: 150px;">
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <h4 class="text-center">Add A New Image</h4>
                <br />
                <br />

                <asp:TextBox ID="NameImage" runat="server" placeholder="Enter Image Name" BorderStyle="Solid" BorderColor="Black" Width="100%" Wrap="True" MaxLength="20"></asp:TextBox>
                <br />
                <br />
                <asp:TextBox ID="ImageDesc" runat="server" placeholder="Enter Image Description" BorderStyle="Solid" BorderColor="Black" Width="100%" Wrap="True" MaxLength="20"></asp:TextBox>
                <br />
                <br />
                <asp:TextBox ID="pinText" runat="server" placeholder="Enter Pincode" BorderStyle="Solid" BorderColor="Black" Width="100%" Wrap="True" MaxLength="6"></asp:TextBox>
                <br />
                <br />
                <asp:TextBox ID="FileBytes" runat="server" placeholder="Hex" BorderStyle="Solid" BorderColor="Black" Width="100%" Wrap="True" style="display:none;"></asp:TextBox>
                <br />
                <br />
                <asp:FileUpload ID="FileUpload1" runat="server" />
                <br />
                <br />

                <asp:Button ID="encryptBtn" runat="server" CssClass="btn btn-primary" Text="Encrypt" OnClick="encryptBtn_Click" />

                <button type="button" class="btn btn-primary" onclick="writeImageData()">Upload</button>
                <br />
                <br />
                <br />
                <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
                <br />
                <asp:Label ID="Label3" runat="server" Text=""></asp:Label>
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


    <script type="text/javascript">

        //get the image table
        var table = document.getElementById("ImageTable");
        //get the current logged in user account
        var user = firebase.auth().currentUser;
        //firebase auth check
        firebase.auth().onAuthStateChanged(function (user) {
            //if there is a user logged in 
            if (user) {
                //get the user ID
                var id = user.uid;
                //get the reference to the database table
                var database = firebase.database().ref().child("Images").child(id);

                //display the users images and data in the table
                database.on("child_added", snap => {
                    var name = snap.child("ImageName").val();
                    var desc = snap.child("ImageDesc").val();
                    var pin = snap.child("PinCode").val();
                    var url = snap.child("ImageURL").val();
                    console.log(".........................................." + name);

                    $("#ImageTable").append("<tr><td>" + name + "</td><td>" + desc + "</td><td>" + pin + "</td><td>" + url + "</td></tr>");

                    $('#ImageTable tr > *:nth-child(3)').hide();
                    $('#ImageTable tr > *:nth-child(4)').hide();
                });
            }

        });

        //method which takes the data from the row the user clicks on
        function getRow() {
            //checks that the table isnt empty
            if (document.getElementById("imageList") != null) {

                //get the table
                var table = document.getElementById("imageList");
                var rows = table.getElementsByTagName('tr');

                var name = '';
                var pin = '';
                var url = '';

                //for method to get all the data from the table row
                for (var i = 1; i < rows.length; i++) {

                    rows[i].i = i;
                    rows[i].onclick = function () {
                        //get the data from the first, third and fourth cell in the row that was clicked on
                        name = table.rows[this.i].cells[0].innerHTML;
                        pin = table.rows[this.i].cells[2].innerHTML;
                        url = table.rows[this.i].cells[3].innerHTML;
                        //display the data in the decrypt div 
                        document.getElementById('<%=imageName.ClientID%>').value = name;
                        document.getElementById('<%=StoredPinCode.ClientID%>').value = pin;
                        document.getElementById('<%=ImageURL.ClientID%>').value = url;
                       
                    };
                }
            }
        }
    </script>
    <script type="text/javascript">

        //method to upload data to database
        function writeImageData() {

            //get the selected image and convert to a byte array
            var ImageBytes = document.getElementById('<%=FileBytes.ClientID%>').value;
            var FileArray = new Uint8Array();
            FileArray = hexStringToByte(ImageBytes);

            //get the user inputs
            var ImageName = document.getElementById('<%=NameImage.ClientID%>').value;
            var ImageDesc = document.getElementById('<%=ImageDesc.ClientID%>').value;
            var Pincode = document.getElementById('<%=pinText.ClientID%>').value;
            var DownloadURL = "Web Upload";

             //get the current logged in user ID 
            var user = firebase.auth().currentUser;
            var id = user.uid;

            //create reference to firebase storage
            var storageRef = firebase.storage().ref();
            var imageRef = storageRef.child('Images/').child(id).child(ImageName)

            //upload encrypted image as a byte array
            imageRef.put(FileArray).then(function (snapshot) {
                console.log('Uploaded the image array');

                //get the download URL
                var downloadURL = imageRef.snapshot.DownloadURL;

            });

            //upload the image name, image description and hashed pincode to the firebase database
            var database = firebase.database().ref('/Images/' + id).push({
                "ImageDesc": ImageDesc,
                "ImageName": ImageName,
                "ImageURL": DownloadURL,
                "PinCode": Pincode
            });
            
            //show success message
            document.getElementById('<%=Label3.ClientID%>').value = "Upload Successful!"; 
            
            
        }

        //convert file to byte array
        function hexStringToByte(str) {
            //https://gist.github.com/tauzen/3d18825ae41ff3fc8981
            if (!str) {
                return new Uint8Array();
            }

            var a = [];
            for (var i = 0, len = str.length; i < len; i += 2) {
                a.push(parseInt(str.substr(i, 2), 16));
            }

            return new Uint8Array(a);
        }

        </script>
        

    



</asp:Content>
