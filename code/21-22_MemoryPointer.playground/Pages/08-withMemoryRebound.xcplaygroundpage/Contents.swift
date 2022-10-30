
//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 使用 withMemoryRebound 代替 bindMemory
import Foundation


let stride = MemoryLayout<Bool>.stride
let alignment = MemoryLayout<Bool>.alignment
let count = 1
let byteCount = stride * count

let rawPointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: alignment)
print(type(of: rawPointer))

print("--使用 bindMemory, 由于错误的参数，可能造成 Crash----")
let pointer: UnsafeMutablePointer<Bool> = rawPointer.bindMemory(to: Bool.self, capacity: count)
print(type(of: pointer))
print(pointer.pointee)

print("--使用 withMemoryRebound 代替 bindMemory----")
rawPointer.withMemoryRebound(to: Bool.self, capacity: count) { boolPointer in
    print(type(of: boolPointer))
    print(boolPointer.pointee)
}




print("--使用 withUnsafeBytes----")
//: ## 将一个 <T> 指针，转化为 raw 指针
withUnsafeBytes(of: pointer) { p -> Void in
    print(type(of: p)) // UnsafeRawBufferPointer
}

//: ## 使用 UnsafeRawBufferPointer 初始化方法也可以，但是 count的指定 容易出错。 所以 建议使用： withUnsafeBytes(of:）
// count 指定错误 error...
// let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: byteCount + 1)
// for byte in bufferPointer {
//     print(byte)
// }

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
