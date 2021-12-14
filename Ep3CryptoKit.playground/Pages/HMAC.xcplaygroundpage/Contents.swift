//: [Previous](@previous)

import Foundation
import CryptoKit

var greeting = "Hello, playground".data(using: .utf8)!

let symetricKey = SymmetricKey(size: .bits256)
let code = HMAC<SHA256>.authenticationCode(for: greeting, using: symetricKey)

greeting.withUnsafeBytes { buffer in
  if HMAC<SHA256>.isValidAuthenticationCode(code, authenticating: buffer, using: symetricKey) {
    print("A integridade da mensagem greeting é está garantida!")
  }
}

// E se alguém mexer nesse dado?

// Live example

//: [Next](@next)
