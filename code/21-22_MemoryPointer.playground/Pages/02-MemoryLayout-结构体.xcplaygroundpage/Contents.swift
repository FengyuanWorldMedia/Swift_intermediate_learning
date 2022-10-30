//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # MemoryLayout-结构体

import Foundation

print("---WolfMan---------------------------------------------------------------------------------------------------------------")
struct WolfMan {
  let age: Int
  let isWarrior: Bool
}
print(MemoryLayout<Int>.size + MemoryLayout<Bool>.size)
// 9 : 8 + 1

print(MemoryLayout<WolfMan>.size)
// 9

print(MemoryLayout<WolfMan>.stride)
// 16

print(MemoryLayout<WolfMan>.alignment)
// 8

print("----WolfManEx--------------------------------------------------------------------------------------------------------------")
struct WolfManEx {
  let isWarrior: Bool
  let age: Int
}
print(MemoryLayout<Int>.size + MemoryLayout<Bool>.size)
// 9 : 8 + 1

print(MemoryLayout<WolfManEx>.size)
// 16

print(MemoryLayout<WolfManEx>.stride)
// 16

print(MemoryLayout<WolfManEx>.alignment)
// 8

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
