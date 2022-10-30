//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # MemoryLayout-内存布局

import Foundation

//: ## MemoryLayout是一个数据结构，用于保存类的内存配置。
//: ### size 连续的内存占用量T，以字节为单位。
//: ### stride 存储在连续存储器或存储器中的一个实例的开始到下一个实例的开始的字节数
//: ### alignment 默认内存对齐方式T，以字节为单位。

// struct MemoryLayout {
//     static var size: Int { get }
//     static var stride: Int { get }
//     static var alignment: Int { get }
//     static func size(ofValue value: T) -> Int
//     static func stride(ofValue value: T) -> Int
//     static func alignment(ofValue value: T) -> Int
//}

//: ## 基本数据内存的对齐方式
print(MemoryLayout<Bool>.size)      // 1
print(MemoryLayout<Bool>.stride)    // 1
print(MemoryLayout<Bool>.alignment) // 1

print(MemoryLayout<UInt8>.size)       // 1
print(MemoryLayout<UInt8>.stride)     // 1
print(MemoryLayout<UInt8>.alignment)  // 1

print(MemoryLayout<Int>.size)       // 8
print(MemoryLayout<Int>.stride)     // 8
print(MemoryLayout<Int>.alignment)  // 8

print(MemoryLayout<Float16>.size)       // 2
print(MemoryLayout<Float16>.stride)      // 2
print(MemoryLayout<Float16>.alignment)   // 2

print(MemoryLayout<Double>.size)       // 8
print(MemoryLayout<Double>.stride)     // 8
print(MemoryLayout<Double>.alignment)  // 8


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
