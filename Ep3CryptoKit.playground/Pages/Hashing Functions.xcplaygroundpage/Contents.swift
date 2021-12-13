//: [Previous](@previous)

import Foundation
import CryptoKit

let str = "This is a normal string".data(using: .utf8)!
let smallString = "smlstr".data(using: .utf8)!

var md5 = Insecure.MD5()
md5.update(data: str)
print(md5.finalize())

// SHA512 normal string
var sha512 = SHA512()
sha512.update(data: str)
print(sha512.finalize())

// SHA512 small string
var sha512SmallString = SHA512()
sha512SmallString.update(data: smallString)
print(sha512SmallString.finalize())

//: [Next](@next)
