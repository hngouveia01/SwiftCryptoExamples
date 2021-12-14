//: [Previous](@previous)
import Foundation
import CryptoKit

let password = "P@ssW0rd".data(using: .utf8)!

let data = "This is your data".data(using: .utf8)!

let key = SymmetricKey(size: .bits256)

let sealedBox = try! AES.GCM.seal(data, using: key)

let combinedData = sealedBox.combined!

print("Dado encriptado: \(String(data: combinedData, encoding: .ascii)!)")

let sealedBoxToOpen = try! AES.GCM.SealedBox(combined: combinedData)

let decryptedData = try! AES.GCM.open(sealedBoxToOpen, using: key)

let decryptedString = String(data: decryptedData, encoding: .utf8)!

print("Dado decriptado: \(decryptedString)")

//: [Next](@next)
