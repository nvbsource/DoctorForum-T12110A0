using System.Security.Cryptography;
using Microsoft.AspNetCore.Cryptography.KeyDerivation;
using System.Text;

namespace Doctors_Forum_Server.Utilities
{
    public class AESEncryption
    {
        private readonly byte[] _key;
        private readonly byte[] _iv;

        public AESEncryption(string secretKey, string salt)
        {
            using (var deriveBytes = new Rfc2898DeriveBytes(secretKey, Encoding.UTF8.GetBytes(salt)))
            {
                _key = deriveBytes.GetBytes(256 / 8);
                _iv = deriveBytes.GetBytes(128 / 8);
            }
        }

        public string Encrypt(string plainText)
        {
            using (var aes = Aes.Create())
            {
                aes.Key = _key;
                aes.IV = _iv;

                using (var encryptor = aes.CreateEncryptor(aes.Key, aes.IV))
                using (var memoryStream = new MemoryStream())
                {
                    using (var cryptoStream = new CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write))
                    using (var streamWriter = new StreamWriter(cryptoStream))
                    {
                        streamWriter.Write(plainText);
                    }

                    return Convert.ToBase64String(memoryStream.ToArray());
                }
            }
        }

        public string Decrypt(string cipherText)
        {
            try
            {
                using (var aes = Aes.Create())
                {
                    aes.Key = _key;
                    aes.IV = _iv;

                    using (var decryptor = aes.CreateDecryptor(aes.Key, aes.IV))
                    using (var memoryStream = new MemoryStream(Convert.FromBase64String(cipherText)))
                    {
                        using (var cryptoStream = new CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read))
                        using (var streamReader = new StreamReader(cryptoStream))
                        {
                            return streamReader.ReadToEnd();
                        }
                    }
                }
            }
            catch (Exception)
            {
                throw new Exception("SecretKey Invalid!");
            }
            
        }
    }
}
