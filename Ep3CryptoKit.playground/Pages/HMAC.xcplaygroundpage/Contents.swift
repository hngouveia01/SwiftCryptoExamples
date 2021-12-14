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


// Notes:

/* O MAC geralmente é convertido para Data quando é enviado pela rede*/
let authenticationCodeData = Data(code)
/*:
 Com o objetivo de prevenir timing attacks, a comparação de um MAC com Data não deixa vazar
 o prefixo compartilhado entre o valor computado e o valor a ser verificado.
 A única maneira de prevenir timing attacks é manter o tempo de computação constante, independente do input.
 */
assert(code == authenticationCodeData)

/*:
 Você pode usar qualquer CryptoKit HashFunction, ou qualquer tipo que conforme com o protocolo HashFunction , para gerar um HMAC.
 */
let sha384MAC = HMAC<SHA384>.authenticationCode(for: greeting, using: symetricKey)
print(sha384MAC)

//: [Next](@next)
