const crypto  = require("crypto");

// The 'generateKeyPairSync' method accepts two arguments:
// 1. The type of keys we want, which in this case is "RSA"
// 2. An object with the properties of the key

const {publicKey, privateKey} = crypto.generateKeyPairSync("rsa",{
// The standard secure default length for RSA keys is 2048 bits
	modulusLength: 2048,
});



// use the public and private keys
//public key and private key variables will be used for encryption and decryption respectively.


// Encryption
// use the publicEncrypt method for encrypting an arbitary message. Must provide a few inputs to this method
// 1. Public key that is generated, 
// 2. The padding scheme (will use OAEP padding), 
// 3. The hashing algorithm (SHA256, which is a recommended secure function as of this date)
// 4. The data to be encrypted (in the form of a buffer since the encrypt method accepts raw bytes)

// This is the data we want to encrypt
const data = "my secret data";

const encryptedData = crypto.publicEncrypt(
  {
	key: publicKey,
	padding: crypto.constants.RSA_PKCS1_OAEP_PADDING,
	oaepHash: "sha256",

},
// Convert the data string to a buffer using 'Buffer.from'
  Buffer.from(data)

);

// The encrypted data is in the form of bytes, so we print it in base64 format
// so that it is displayed in a more readble form

console.log("encrypted data: ", encryptedData.toString("base64"));




