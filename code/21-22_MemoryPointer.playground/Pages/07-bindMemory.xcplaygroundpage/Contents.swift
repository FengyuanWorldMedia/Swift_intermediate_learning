//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # bindMemory & assumingMemoryBound
import Foundation


let stride = MemoryLayout<Int>.stride
let alignment = MemoryLayout<Int>.alignment
let count = 1
let byteCount = stride * count

let rawPointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: alignment)
defer {
    rawPointer.deallocate()
}

//: ## 把 rawPointer 转化为一个指定类型的 指针
let pointer: UnsafeMutablePointer<Int> = rawPointer.bindMemory(to: Int.self, capacity: count)

//: ## 假定把 rawPointer 转化为一个指定类型的 指针
//let pointer = rawPointer.assumingMemoryBound(to: Int.self)
pointer.initialize(repeating: 0, count: count)
defer {
    pointer.deinitialize(count: count)
}

pointer.pointee = 11

print(rawPointer.load(as: Int.self))
print(pointer.pointee)


rawPointer.storeBytes(of: 9999, toByteOffset: 0, as: Int.self)
print(rawPointer.load(as: Int.self))
print(pointer.pointee)


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)


