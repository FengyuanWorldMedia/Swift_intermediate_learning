//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)


//: # UnsafeMutableRawPointer & UnsafeRawBufferPointer
import Foundation


let numbers = [11, 22, 33, 44, 55, 66]

let stride = MemoryLayout<Int>.stride
let alignment = MemoryLayout<Int>.alignment
let byteCount = stride * numbers.count  //  需要内存总数

let pointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: alignment)
defer {
    pointer.deallocate()
}
  
for (index, value) in numbers.enumerated() {
    // stride * index 为 第index个元素的 地址位置
    // storeBytes(of:as:) 为保存到 指定地址的 数据，转化为 字节码. 和 load(as:) 是相反的操作。
    pointer.advanced(by: stride * index).storeBytes(of: value, as: Int.self)
}


print(pointer.advanced(by: stride * 5).load(as: Int.self)) // 66

let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: byteCount)
for index in 0..<numbers.count {
    let value = bufferPointer.load(fromByteOffset: stride * index, as: Int.self)
    print(index, "-", value)
}



//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
