//: [Previous](@previous)

import Foundation
import CryptoKit

var input = "Hello, playground".data(using: .utf8)!

// Validar assinaturas
let privateKey = P521.Signing.PrivateKey()
let publicKey = privateKey.publicKey

let otherPrivateKey = P521.Signing.PrivateKey()
let otherPublicKey = otherPrivateKey.publicKey

let signature = try privateKey.signature(for: input)

if publicKey.isValidSignature(signature, for: input) {
  print("Com a chave publica foi possível verificar que o dado foi assinado pelo dono dessa chave")
}

if !otherPublicKey.isValidSignature(signature, for: input) {
  print("Não é válido com a chave privada par dessa chave pública")
}

// Key Agreement
let side1PrivateKey = P521.KeyAgreement.PrivateKey()
let side1PublicKey = side1PrivateKey.publicKey

let side2PrivateKey = P521.KeyAgreement.PrivateKey()
let side2PublicKey = side2PrivateKey.publicKey

let saltKey = SymmetricKey(size: .bits256)
let salt = saltKey.withUnsafeBytes { Data($0) }

// Key Derivation
let side1SharedSecret = try! side1PrivateKey.sharedSecretFromKeyAgreement(with: side2PublicKey)
let side1SymmetricKey = side1SharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self, salt: salt, sharedInfo: Data(), outputByteCount: 32)

let side2SharedSecret = try! side2PrivateKey.sharedSecretFromKeyAgreement(with: side1PublicKey)
let side2SymmetricKey = side2SharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self, salt: salt, sharedInfo: Data(), outputByteCount: 32)

// Side 1 envia a message para o Side 2
let message = "SUP BROTHA".data(using: .utf8)!
let encriptedSide1 = try ChaChaPoly.seal(message, using: side1SymmetricKey)

 // Recebendo a mensagen
let decryptedMessage = try! ChaChaPoly.open(encriptedSide1, using: side2SymmetricKey)
let decryptedMessageString = String(data: decryptedMessage, encoding: .utf8)!
print(decryptedMessageString)

//: [Next](@next)
