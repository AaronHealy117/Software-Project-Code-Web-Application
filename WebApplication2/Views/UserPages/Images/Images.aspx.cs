using Org.BouncyCastle.Crypto;
using Org.BouncyCastle.Crypto.Engines;
using Org.BouncyCastle.Crypto.Paddings;
using Org.BouncyCastle.Crypto.Parameters;
using Org.BouncyCastle.Security;
using System;
using System.Diagnostics;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI.WebControls;

namespace WebApplication2.Views.UserPages.Images
{

    /*
     * 
     * Code Copied from:
     * Title: FileUpload.FileBytes Property
     * Author: msdn.microsoft
     * Availability: https://msdn.microsoft.com/en-us/library/system.web.ui.webcontrols.fileupload.filebytes(v=vs.110).aspx
     * 
     * Code Copied from:
     * Title: C# TripleDES Provider without an Initialization Vector?
     * Author: Rick Strahl
     * Availability: https://stackoverflow.com/questions/12522191/c-sharp-tripledes-provider-without-an-initialization-vector
     * 
     * Code Copied from:
     * Title: Bouncy Castle - .Net Implementation – Triple DES Algorithm
     * Author: sbh
     * Availability: https://www.go4expert.com/articles/bouncy-castle-net-implementation-triple-t24829/
     * 
     * Code Copied from:
     * Title: How to implement Triple DES in C# (complete example)
     * Author: Chris Gessler
     * Availability: https://stackoverflow.com/questions/11413576/how-to-implement-triple-des-in-c-sharp-complete-example
     * 
     * Code Modified from:
     * Title: PBKDF2WithHmacSHA1.java
     * Author: seraphy
     * Availability: https://gist.github.com/seraphy/3072028
     *
     * Code Modified from:
     * Title: Hex to Byte Array in C# and Java Gives Different Results
     * Author: Jon Skeet
     * Availability: https://stackoverflow.com/questions/16922747/hex-to-byte-array-in-c-sharp-and-java-gives-different-results
     *
     * Code Modified from:
     * Title: Generate Secure Password Hash : MD5, SHA, PBKDF2, BCrypt Examples
     * Author: Lokesh Gupta
     * Availability: https://howtodoinjava.com/security/how-to-generate-secure-password-hash-md5-sha-pbkdf2-bcrypt-examples/
     *
     * Code Modified from:
     * Title: How to: Parse Strings Using String.Split (C# Guide)
     * Author: Multiple Contributors
     * Availability: https://docs.microsoft.com/en-us/dotnet/csharp/how-to/parse-strings-using-split
     *
     * Code Modified from:
     * Title: How can I convert a hex string to a byte array? [duplicate]
     * Author: JaredPar
     * Availability: https://stackoverflow.com/questions/321370/how-can-i-convert-a-hex-string-to-a-byte-array
     * 
     * 
     */

    public partial class Images : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //decrypt button event
        protected void Button1_Click(object sender, EventArgs e)
        {
            //get the needed data and the user inputted pin code
            String name = imageName.Text;
            String enterPin = pincodeInput.Text;
            String storedPin = StoredPinCode.Text;
            String url = ImageURL.Text;

            //validate the inputted pin code with the hash stored in the database
            bool match = ValidateHash(enterPin, storedPin);

            //if the pin code is not 6 digits show error message
            if (enterPin.Length < 5)
            {
                Label1.ForeColor = Color.Red;
                Label1.Text = "Please Enter a Pin Code";
                return;
            }

            //if the pin codes match 
            if (match)
            {
                //create web client
                var request = new WebClient();

                //get the image as a byte array from firebase storage
                byte[] imageBytes = request.DownloadData(url);
                //decrypt the image
                byte[] decrypted = desDecrypt(imageBytes, storedPin);

                //convert the image byte array back to an image and download it to the users downloads folder
                using (System.Drawing.Image image = System.Drawing.Image.FromStream(new MemoryStream(decrypted)))
                {
                    String ImageName = name + ".png";
                    image.Save(@"C:\\Users\\x14532757\\Desktop\\" + ImageName, ImageFormat.Png);
                }

                //show success message
                Label1.Text = "Image Decryption Successful, Please Check your Desktop";
            }
            //if pin code does not match show error message
            else
            {
                String error = "Please enter the correct password!";
                Label1.Text = error;
            }
            
        }

       
        protected void encryptBtn_Click(object sender, EventArgs e)
        {
            //get user inputs
            String imageName = NameImage.Text;
            String imageDesc = ImageDesc.Text;
            String enteredPin = pinText.Text;

            //input validation
            if (imageName.Length < 1)
            {
                Label2.ForeColor = Color.Red;
                Label2.Text = "Please Enter an Image Name";
                return;
            }
            if (imageDesc.Length < 1)
            {
                Label2.ForeColor = Color.Red;
                Label2.Text = "Please Enter an Image Description";
                return;
            }
            if (enteredPin.Length < 1)
            {
                Label2.ForeColor = Color.Red;
                Label2.Text = "Please Enter a Pin Code";
                return;
            }
            
            //get the file length
            int FileLength = FileUpload1.PostedFile.ContentLength;

            //if the file is 0 no file selected
            if (FileLength.Equals(0))
            {
                Label2.ForeColor = Color.Red;
                Label2.Text = "Please Select a File";
                return;
            }

            //get the image to a byte array
            byte[] fileBytes = new byte[FileLength-1];
            fileBytes = FileUpload1.FileBytes;

            //hash the pin code using PBKDF2
            String hashed = Hash(enteredPin);

            //encrypt the image
            byte[] encrypted = desEncrypt(fileBytes, hashed);
            String encryptedHex = ByteArrayToHexString(encrypted);

            //set the encrypted data in the frontend
            NameImage.Text = imageName;
            ImageDesc.Text = imageDesc;
            pinText.Text = hashed;
            FileBytes.Text = encryptedHex;

            //show success message
            Label2.Text = "Encryption Successful";
            
        }

        //Triple DES Encryption
        private byte[] desEncrypt(byte[] image, string pin)
        {
            //get hashed pincode to byte array
            byte[] keyBytes = Encoding.UTF8.GetBytes(pin);
            
            //make sure the keybytes are 24 bytes and copy the first 24 bytes
            byte[] newBytes = new byte[24];
            Array.Copy(keyBytes, 0, newBytes, 0, 24);

            //create new IV byte array
            byte[] IV = new byte[8];

            //Create C# TRiple DES algorithm
            TripleDES tdes = TripleDES.Create();
            //create the Triple DES parameters and the modes of Triple DES
            tdes.Key = newBytes;
            tdes.Mode = CipherMode.CBC;
            tdes.Padding = PaddingMode.PKCS7;
            tdes.IV = IV;

            //create encryptor
            var Encryptor = tdes.CreateEncryptor();
            //encrypt the image bytes
            byte[] outpur = Encryptor.TransformFinalBlock(image, 0, image.Length);
            tdes.Clear();

            return outpur;

        }

        private byte[] desDecrypt(byte[] image, String pin)
        {
            //get hashed pincode to byte array
            byte[] keyBytes = Encoding.UTF8.GetBytes(pin);

            //make sure the keybytes are 24 bytes and copy the first 24 bytes
            byte[] newBytes = new byte[24];
            Array.Copy(keyBytes, 0,newBytes, 0, 24);

            //create new IV byte array
            byte[] IV = new byte[8];

            //Create C# TRiple DES algorithm
            TripleDES tdes = TripleDES.Create();
            //create the Triple DES parameters and the modes of Triple DES
            tdes.Key = newBytes;
            tdes.Mode = CipherMode.CBC;
            tdes.Padding = PaddingMode.PKCS7;
            tdes.IV = IV;

            //create Decryptor
            var Encryptor = tdes.CreateDecryptor();
            //encrypt the image bytes
            byte[] outpur = Encryptor.TransformFinalBlock(image, 0, image.Length);
            tdes.Clear();

            return outpur;

        }

        
            private string Hash(string pin)
            {
            //create iterations and byte length
            int ITERATIONS = 10000;
            int BIT_LENGTH = 24;

            //get secure random salt 
            byte[] salt = GetSalt();
            //create C# PBKDF2 hashing algorithm and hash the user entered pin code
            var kf = new Rfc2898DeriveBytes(pin, salt, ITERATIONS);
            //get hash to byte array to byte length
            byte[] key = kf.GetBytes(BIT_LENGTH);
            //convert hash and salt byte array to hex and combine them
            string hashed = ByteArrayToHexString(salt) + ":" + ByteArrayToHexString(key);

                return hashed;
            }

        //method to convert byte array to hex 
        private static string ByteArrayToHexString(byte[] byteArray)
            {
                StringBuilder builder = new StringBuilder();
                foreach (byte b in byteArray)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();

            }

        //method to create 16 byte random salt
        private static byte[] GetSalt()
            {
                RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
                byte[] salt = new byte[16];
                provider.GetBytes(salt);

                return salt;
            }

        //hash validation methiod
        private bool ValidateHash(string originalPassword, string storedPassword)
            {
            //the entire hash is separated by : 
            String[] parts = storedPassword.Split(':');
            //first part is the salt
            byte[] salt = fromHex(parts[0]);
            //second part is actual hash
            byte[] hash = fromHex(parts[1]);

            int ITERATIONS = 10000;
            int BIT_LENGTH = 24;

            //create C# PBKDF2 hashing algorithm and hash the user entered pin code using the same salt
            var kf = new Rfc2898DeriveBytes(originalPassword, salt, ITERATIONS);

            //get hash to byte array to byte length
            byte[] testHash = kf.GetBytes(BIT_LENGTH);

            //test to see if the stored hash in the database is the same the user entered pin code
            int diff = hash.Length ^ testHash.Length;
                for (int i = 0; i < hash.Length && i < testHash.Length; i++)
                {
                    diff |= hash[i] ^ testHash[i];
                }
                return diff == 0;

            }

        //method to convert hex back to byte array
        private static byte[] fromHex(String hex)
            {
                return Enumerable.Range(0, hex.Length)
                         .Where(x => x % 2 == 0)
                         .Select(x => Convert.ToByte(hex.Substring(x, 2), 16))
                         .ToArray();
            }

        
    }
}
