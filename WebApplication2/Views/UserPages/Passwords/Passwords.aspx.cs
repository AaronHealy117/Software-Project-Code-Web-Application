using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;

namespace WebApplication2.Views.UserPages.Passwords
{
    /*
     * Code Copied and Modified from:
     * Title: Cross-platform-AES-encryption
     * Author: Pakhee
     * Availability: https://github.com/Pakhee/Cross-platform-AES-encryption/blob/master/C-Sharp/CryptLib.cs
     * 
     * Code modified from:
     * Title: encryption.java
     * Author:  itarato
     * Availability: https://gist.github.com/itarato/abef95871756970a9dad
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


    public partial class Passwords : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        
        protected void decryptBtn_Click(object sender, EventArgs e)
        {
            //get the users data and pin code input
            String pass = passwordTxt.Text;
            String pin = pincodeInput.Text;
            String OGpin = Text1.Text;
            
            //validate the entered pin code with the one stored in the database
            bool match = ValidateHash(pin, OGpin);
            //if the pin codes match 
            if (match)
            {
                String iv = "";

                //get instance of AESCipher internal class
                AESCipher AESCipher = new AESCipher();
                //decrypt the password
                String decrypted = AESCipher.decrypt(pass, OGpin, iv);

                //set the text view with the decrypted password
                passwordTxt.Text = decrypted;
                //set pin code input to blank
                pincodeInput.Text = "";
                
                String success = "Decryption Successful!";
                Label1.Text = success;

            }
            //pin code does not match so show error message
            else
            {
                String error = "Please enter the correct password!";
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = error;
            }
            

        }

        protected void encryptBtn_Click(object sender, EventArgs e)
        {
            //get the users data and pin code input
            String pass = passText.Text;
            String passname = passName.Text;
            String pin = pinText.Text;

            //server side input validation
            if (passname.Length < 1)
            {
                Label2.ForeColor = System.Drawing.Color.Red;
                Label2.Text = "Please Enter a Password Name";
                return;
            }
            if (pass.Length < 1)
            {
                Label2.ForeColor = System.Drawing.Color.Red;
                Label2.Text = "Please Enter a Password";
                return;
            }
            if (pin.Length < 1)
            {
                Label2.ForeColor = System.Drawing.Color.Red;
                Label2.Text = "Please Enter a Pin Code";
                return;
            }
            
            //hash the user inputted pincode
            String key = Bouncy.Hash(pin);
            //get instance of AESCipher internal class
            AESCipher AESCipher = new AESCipher();
            //generate a 16 byte random IV
            byte[] ivBytes = AESCipher.GenerateRandomIV(16);
            //convert IV to string
            String iv = Convert.ToBase64String(ivBytes);
            //encrypt the password using the pin code and the IV
            String encrypted = AESCipher.encrypt(pass, key, iv);
            Debug.WriteLine("encrypted text..................................." + encrypted);

            //set the encrypted password and hashed pin code on screen
            passText.Text = encrypted;
            pinText.Text = key;
            
        }
        
        public class AESCipher
        {
            //create encoding, AES cipher and byte arrays needed
            UTF8Encoding _enc;
            RijndaelManaged _rcipher;
            byte[] _key, _pwd, _ivBytes, _iv;

        //Encryption mode enumeration
        private enum EncryptMode { ENCRYPT, DECRYPT };

            //Create AES cipher and all parameters
                public AESCipher()
                {
                    _enc = new UTF8Encoding();
                    _rcipher = new RijndaelManaged();
                    _rcipher.Mode = CipherMode.CBC;
                    _rcipher.Padding = PaddingMode.PKCS7;
                    _rcipher.KeySize = 256;
                    _rcipher.BlockSize = 128;
                    _key = new byte[32]; // 256 bits
                    _iv = new byte[_rcipher.BlockSize / 8]; //128 bit / 8 = 16 bytes
                    _ivBytes = new byte[16];
                }


                private String encryptDecrypt(string _inputText, string _encryptionKey, EncryptMode _mode, string _initVector)
                {

                    string _out = "";
                    
                    //get hashed pin code to bytes array
                    _pwd = Encoding.UTF8.GetBytes(_encryptionKey);
                    //get IV to byte array
                    _ivBytes = Encoding.UTF8.GetBytes(_initVector);

                    //check that the IV and hashed key are the correct size in bytes
                    int len = _pwd.Length;
                    if (len > _key.Length)
                    {
                        len = _key.Length;
                    }
                    int ivLenth = _ivBytes.Length;
                    if (ivLenth > _iv.Length)
                    {
                        ivLenth = _iv.Length;
                    }

                    //copy hashed pincode and IV bytes to AES key and IV
                    Array.Copy(_pwd, _key, len);
                    Array.Copy(_ivBytes, _iv, ivLenth);
                    _rcipher.Key = _key;
                    _rcipher.IV = _iv;

                    //encrypt mode
                    if (_mode.Equals(EncryptMode.ENCRYPT))
                    {
                        //encrypt the password
                        byte[] plainText = _rcipher.CreateEncryptor().TransformFinalBlock(_enc.GetBytes(_inputText),
                            0, _inputText.Length);
                        //combine the ciphertext and the IV so we can use it later
                        byte[] combined = new byte[_iv.Length + plainText.Length];
                        System.Buffer.BlockCopy(_iv, 0, combined, 0, _iv.Length);
                        System.Buffer.BlockCopy(plainText, 0, combined, _iv.Length, plainText.Length);
                        //convert ciphertext bytes to hex 
                        _out = Convert.ToBase64String(combined);
                    }

                    //decrypt mode
                    if (_mode.Equals(EncryptMode.DECRYPT))
                    {
                        //decrypt the ciphertext back to plaintext using the same IV
                        byte[] plainText = _rcipher.CreateDecryptor().TransformFinalBlock(Convert.FromBase64String(_inputText),
                            0, Convert.FromBase64String(_inputText).Length);
                        //convert plaintext bytes back to hex
                        String outputToString = _enc.GetString(plainText);
                        //remove IV from plaintext
                        String trimmed = outputToString.Remove(0, _iv.Length-1);
                        _out = trimmed;
                    }
                    _rcipher.Dispose();
                    return _out;
                }

                public string encrypt(string _plainText, string _key, string _initVector)
                {
                    return encryptDecrypt(_plainText, _key, EncryptMode.ENCRYPT, _initVector);
                }

                public string decrypt(string _encryptedText, string _key, string _initVector)
                {
                    return encryptDecrypt(_encryptedText, _key, EncryptMode.DECRYPT, _initVector);
                }

                //used to create secure random IV
                public byte[] GenerateRandomIV(int length)
                {
                    byte[] randomBytes = new byte[length];
                    using (RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider())
                    {
                        rng.GetBytes(randomBytes);  
                    }
                    return randomBytes;
                }

            }

        //hashing internal class
        private class Bouncy
        {
            //PBKDF2 Hashing method
            public static string Hash(string pin)
            {
                //create iterations and byte length
                int ITERATIONS = 10000;
                int BYTE_LENGTH = 32;
                //get secure random salt 
                byte[] salt = GetSalt();
                //create C# PBKDF2 hashing algorithm and hash the user entered pin code
                var kf = new Rfc2898DeriveBytes(pin, salt, ITERATIONS);
                //get hash to byte array to byte length
                byte[] key = kf.GetBytes(BYTE_LENGTH);
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
            
        }

       //hash validation methiod
        public bool ValidateHash(string originalPassword, string storedPassword)
        {
            //the entire hash is separated by : 
            String[] parts = storedPassword.Split(':');
            //first part is the salt
            byte[] salt = fromHex(parts[0]);
            //second part is actual hash
            byte[] hash = fromHex(parts[1]);

            int ITERATIONS = 10000;
            int BYTE_LENGTH = 32;

            //create C# PBKDF2 hashing algorithm and hash the user entered pin code using the same salt
            var kf = new Rfc2898DeriveBytes(originalPassword, salt, ITERATIONS);
            //get hash to byte array to byte length
            byte[] testHash = kf.GetBytes(BYTE_LENGTH);

            //test to see if the stored hash in the database is the same the user entered pin code
            int diff = hash.Length ^ testHash.Length;
            for (int i = 0; i < hash.Length && i < testHash.Length; i++)
            {
                diff |= hash[i] ^ testHash[i];
            }
            return diff == 0;

        }
        
        //method to convert hex back to byte array
        public static byte[] fromHex(String hex)
        {
            return Enumerable.Range(0, hex.Length)
                     .Where(x => x % 2 == 0)
                     .Select(x => Convert.ToByte(hex.Substring(x, 2), 16))
                     .ToArray();
        }


    }
}


    


