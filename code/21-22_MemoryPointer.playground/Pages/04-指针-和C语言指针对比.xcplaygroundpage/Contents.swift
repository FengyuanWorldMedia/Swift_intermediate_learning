//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # UnsafeMutablePointer & UnsafeRawPointer
import Foundation

//: ## UnsafeMutablePointer
//: ### 您可以使用UnsafeMutablePointer类型的实例访问内存中特定类型的数据。指针可以访问的数据类型是pointee的指针类型。
//: ### UnsafeMutablePointer不提供自动内存管理或对齐保证。您负责通过不安全的指针处理使用的任何内存的生命周期，以避免泄漏或未定义的行为。
//: ### 手动管理的内存可以是非类型化的，也可以绑定到特定类型。您可以使用UnsafeMutablePointer类型访问和管理绑定到特定类型的内存。

//: ## UnsafeRawPointer
//: ### UnsafeRawPointer类型不提供自动内存管理、类型安全和对齐保证。
//: ### 您负责通过不安全的指针处理使用的任何内存的生命周期，以避免泄漏或未定义的行为。
//: ### 手动管理的内存可以是非类型化的，也可以绑定到特定类型。
//: ### 您可以使用UnsafeRawPointer类型访问和管理内存中的原始字节，无论该内存是否已绑定到特定类型。

//: ### UnsafeRawPointer 可以使用 UnsafeMutablePointer 进行初始化。

var x: Int = 20
var xPointer: UnsafeMutablePointer<Int> = .init(&x)

print("1. 变量x的地址:", UnsafeRawPointer(&x))
print("2. 变量x的值:", x)
print("3. 变量xPointer的地址:", UnsafeRawPointer(&xPointer))
print("4. 变量xPointer的值:", xPointer) // 和变量x 的地址是一样的。
print("5. 变量xPointer所指向地址的值:", xPointer.pointee)

xPointer.pointee = 90

print("6. 变量x的值:", x)
print("7. 变量xPointer所指向地址的值:", xPointer.pointee)

x = 100
print("8. 变量x的值:", x)
print("9. 变量xPointer所指向地址的值:", xPointer.pointee)


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
