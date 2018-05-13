<%@ Page Title="Index" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="WebApplication2._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- jumbotron -->
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

    <!-- opening -->
    <div class="row" style="height: auto; background-color: #d24958;" >

        <div class="container" style="margin-top: 150px; margin-bottom:150px;">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="text-center" style="color: snow;">Secure Your Data</h1>
                    <br />
                    <h4 class="text-center" style="color: snow;">Keep your data secure using a cloud database and secure encryption</h4>

                    <br />
                    <p class="text-center" style="color: snow;">
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
                  Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
                  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur
               
                    </p>
                </div>
            </div>

        </div>

    </div>

    <!-- features -->
    <div class="row" style="background-color: lightgray; height: auto;" id="features">

        <div class="container" style="margin-top: 150px; margin-bottom:150px;">
            <h1 class="text-center heading-colour" style=" color: #d24958;">FEATURED SERVICES</h1>
            <br />
            <p class="text-center" style="color: black;">Provides Encryption for variuos types of data!!</p>
            <br />
            <br />
            <br />
            <br />
            <div class="row">
                <div class="col-md-3">
                    <!-- 
                        Image taken from:

                        <div>Icons made by <a href="https://www.flaticon.com/authors/smashicons" title="Smashicons">Smashicons</a> 
                        from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" 
                        title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
                    -->
                    <img src="../../Images/password.png" alt="mail" style="display: block; margin-left: auto; margin-right: auto; height: 70px; width: 70px;" />
                    <br />
                    <br />
                    <h4 class="text-center" style="color: black;">Passwords</h4>
                </div>
                <div class="col-md-3">
                    <!-- 
                        Image taken from:

                        <div>Icons made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" 
                        title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" 
                        title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
                    -->
                    <img src="../../Images/text.png" alt="mail" style="display: block; margin-left: auto; margin-right: auto; height: 70px; width: 70px;" />
                    <br />
                    <br />
                    <h4 class="text-center" style="color: black;">Text</h4>
                </div>
                <div class="col-md-3">
                    <!-- 
                        Image taken from:

                        <div>Icons made by <a href="https://www.flaticon.com/authors/smashicons" title="Smashicons">
                        Smashicons</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> 
                        is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
                    -->
                    <img src="../../Images/files.png" alt="mail" style="display: block; margin-left: auto; margin-right: auto; height: 70px; width: 70px;" />
                    <br />
                    <br />
                    <h4 class="text-center" style="color: black;">Files</h4>
                </div>
                <div class="col-md-3">
                    <!-- 
                        Image taken from:

                        <div>Icons made by <a href="https://www.flaticon.com/authors/smashicons" title="Smashicons">
                        Smashicons</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> 
                        is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
                    -->
                    <img src="../../Images/image.png" alt="mail" style="display: block; margin-left: auto; margin-right: auto; height: 70px; width: 70px;" />
                    <br />
                    <br />
                    <h4 class="text-center" style="color: black;">Images</h4>
                </div>

            </div>
        </div>
    </div>


    <!-- about us -->
    <div class="container" style="margin-top: 150px; margin-bottom:150px;" id="aboutUs">
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <h1 class="text-center" style="color: #d24958;">ABOUT US</h1>
                <br />
                <p class="text-center">
                    We take security very seriously here at Kryptium
                </p>
                <br />
            </div>
        </div>

        <div class="row">
            <div class="col-md-4" style="height: 560px; margin-top: 20px; background-color: lightgray; border-radius:20px;">
                <br />
                <br />
                <br />
                <br />
                <h3 class="text-center" style="color:#d24958;">Secure Encryption</h3>
                <br />
                <br />
                <br />
                <br />
                <p class="text-center" style="color:black;">
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
                  Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
                  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur
                </p>
            </div>
            <div class="col-md-4" style="height: 600px; background-color: #d24958; border-radius:20px;">
                <br />
                <br />
                <br />
                <h3 class="text-center">Cross Platform</h3>
                <br />
                <br />
                <br />
                <br />
                <p class="text-center" style="color:white;">
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
                  Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
                  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur
                </p>
            </div>
            <div class="col-md-4" style="height: 560px; margin-top: 20px; background-color: lightgray; border-radius:20px;">
                <br />
                <br />
                <br />
                <br />
                <h3 class="text-center" style="color:#d24958;">Four Data Types</h3>
                <br />
                <br />
                <br />
                <br />
                <p class="text-center" style="color:black;">
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
                  Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
                  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur
                </p>
            </div>
        </div>

    </div>



    <!--Contact form -->
    <div class="row" style="margin-bottom: 0px; height: auto; background-color: lightgray;" id="contact">

        <div class="container" style="margin-top: 150px; margin-bottom: 150px;">
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <h1 class="text-center" style="color: #d24958;">Contact Us</h1>
                    <br />
                    <p class="text-center">
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget risus vitae massa 
                        semper aliquam quis mattis quam.
                    </p>

                    <br />
                    <br />
                   
                    <fieldset>
                        <div class="form-group">
                            <asp:TextBox ID="TextBox1" runat="server" class="form-control" aria-describedby="emailHelp" placeholder="Full Name"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="TextBox2" runat="server" class="form-control" placeholder="Email Address" TextMode="Email"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="TextBox3" runat="server" class="form-control" placeholder="Your Message" TextMode="MultiLine" Rows="5"></asp:TextBox>
                        </div>

                    </fieldset>
                    <asp:Button ID="Button1" runat="server" Text="Submit" class="btn btn-primary"  />

                </div>
            </div>
            
        </div>

    </div>


</asp:Content>
