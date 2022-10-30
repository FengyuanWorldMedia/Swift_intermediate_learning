//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # MemoryLayout-类对象

import Foundation
 
print("---WolfMan---------------------------------------------------------------------------------------------------------------")

class WolfMan {
  let isWarrior: Bool = true // 1
  let age: Int = 10 // 8
}

//: ## 类对象 MemoryLayout.size 始终是 8 bytes(class类型的引用指针)。
print(MemoryLayout<WolfMan>.size)      // 8
print(MemoryLayout<WolfMan>.stride)    // 8
print(MemoryLayout<WolfMan>.alignment)  // 8

print("---WolfManEx---------------------------------------------------------------------------------------------------------------")

//: ## 使用 class_getInstanceSize方法获取 类对象在 堆heap中的 大小
//: ### 一个空的 类对象，其元数据metadata（数据类型 + 引用计数）, 始终占有 16字节大小。
class EmptyClass {}
print(MemoryLayout<EmptyClass>.size)            // 8

print(class_getInstanceSize(EmptyClass.self)) // 16

class WolfManEx {
    let age: Int = 10         // 8
    let isWarrior: Bool = true // 1 + 7 padding
}
print(class_getInstanceSize(WolfManEx.self)) // 32 (16 + 16)


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
