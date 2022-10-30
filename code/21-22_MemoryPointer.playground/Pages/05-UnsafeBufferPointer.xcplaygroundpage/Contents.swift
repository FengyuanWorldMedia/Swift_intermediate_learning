//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # UnsafeBufferPointer & UnsafeMutableBufferPointer

import Foundation

let numbers = [11, 22, 33, 44, 55, 66]
let len = numbers.count

//: ### 开辟内存空间，数量和数组numbers的 元素个数一样
let pointer: UnsafeMutablePointer<Int> = UnsafeMutablePointer<Int>.allocate(capacity: len)

//: ### 用0初始化开辟的内存空间
pointer.initialize(repeating: 0, count: len)
defer {
    print("回收♻️内存")
    pointer.deinitialize(count: len)
    pointer.deallocate()
}

print("----初始化的 数据-----")

//: ## UnsafeBufferPointer 最重要的是知道 元素个数 count, 可以被迭代访问。初始化的时候，给一个 地址UnsafePointer 和 元素个数。
//: ## UnsafeBufferPointer 有一个 baseAddress 属性，是UnsafePointer 类型, 和初始化的 start参数是相等的。
let bufferPointer1: UnsafeBufferPointer<Int> = UnsafeBufferPointer(start: pointer, count: len)
for (index, value) in bufferPointer1.enumerated() {
    print(index, "-", value)
}
print(pointer)
print(bufferPointer1.baseAddress)



print("----拷贝numbers数据到 指针的指向数据-----")
for (index, value) in numbers.enumerated() {
    pointer.advanced(by: index).pointee = value
}

print("----被修改后的数据-----")
let bufferPointer2: UnsafeBufferPointer<Int> = UnsafeBufferPointer(start: pointer, count: len)
for (index, value) in bufferPointer2.enumerated() {
    print(index, "-", value)
}

print("----获取最后一个数据-----")
print(pointer.advanced(by: 5).pointee); // 66


print("----使用 UnsafeMutableBufferPointer 修改数据-----")
//: ## UnsafeMutableBufferPointer 可以通过下标修改 值。
let bufferPointer3 = UnsafeMutableBufferPointer(start: pointer, count: len)
for (index, value) in bufferPointer3.enumerated() {
    bufferPointer3[index] = value + 1
}

print(pointer.advanced(by: 5).pointee); // 67

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
