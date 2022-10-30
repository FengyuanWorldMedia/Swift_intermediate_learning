
//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 指针状态

import Foundation

let stride = MemoryLayout<Int>.stride
let alignment = MemoryLayout<Int>.alignment
let count = 1
let byteCount = stride * count

//: ## Unallocated
//: ### 1.没有开辟内存的指针
var pointer: UnsafeMutablePointer<Int>?
//: ### 2.开辟内存后，又收回的 指针
var xPointer: UnsafeMutablePointer<Int> = UnsafeMutablePointer<Int>.allocate(capacity: 1)
xPointer.deallocate()

//: ## Allocated & Uninitialized
//: ### 1. 开辟内存, 没有初始化的 指针
let allocated = UnsafeMutablePointer<Int>.allocate(capacity: 1)
//: ### 2. 开辟内存,  初始化 后，又反初始化操作后的 指针
let allocated2 = UnsafeMutablePointer<Int>.allocate(capacity: 1)
allocated2.initialize(repeating: 100, count: 1)
allocated2.deinitialize(count: 1)


//: ## Initialized
let pointer3 = UnsafeMutablePointer<Int>.allocate(capacity: 1)
pointer3.initialize(to: 100) //  or allocated.initialize(repeating: 100, count: 1)


var bytes: [UInt8] = [10, 20, 30, 40]
let uint8Pointer = UnsafeMutablePointer<UInt8>.allocate(capacity: 4)
uint8Pointer.initialize(from: &bytes, count: 4)
//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
