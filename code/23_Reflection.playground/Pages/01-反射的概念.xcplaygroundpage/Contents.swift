//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 反射的概念

//: ### 反射是一种 让我们在运行时（Runtime）获取 对象的结构定义，元数据（metadata）的技术。
//: ### Swift的反射使我们能够，迭代读取 类型所具有的所有存储属性的值,获取类型信息，无论是struct、class 还是任何其他类型。

//: ### 元数据的概念：
//: ### 比如：
//: ###    类-->类对象
//: ###    类的元数据-->类
// name             ----> Sting
// Sting.self       ----> String.Type
// String.Type.self ----> String.Type.Type
//: ### 相比其他开发语言，尤其是java，Swift提供的 反射API限制太多了。
//: ### 尽管如此，已经提供的API，也能在开发中发挥很好的作用。

import Foundation

//: ## Monster 的定义
struct Monster {
    var name: String
    var ranking: Int
    var desc: String?
    
    func fight() {
        print("fight")
    }
}

let monster = Monster(name: "狼人1号", ranking: 10, desc: "最棒的一个士兵")

let mirror = Mirror(reflecting: monster)


for child in mirror.children {
    print("Property name:", child.label)
    print("Property value:", child.value)
}


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
