//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 迭代器协议

//: ## IteratorProtocol
// protocol IteratorProtocol {
//     associatedtype Element
//     func next() -> Self.Element?
// }

//: ## 从IteratorProtocol定义中可以看出
//: ### 1.协议有关联类型Element
//: ### 2.next方法返回，迭代器遵循该协议的集合对象的下一个元素对象，如果已经没有元素了，那就返回nil。
//: ### 3.结构体，枚举或者类都可以实现该协议

//: ## 遵循IteratorProtocol的Built-in常用数据类型(有的是有条件的遵循协议)
//: ### Dictionary.Iterator
//: ### Dictionary.Keys.Iterator, Dictionary.Values.Iterator
//: ### Set.Iterator
//: ### String.Iterator
//: ### IndexingIterator
//: ### EnumeratedSequence.Iterator
//: ### StrideToIterator


//: ## For 语句的基础是【IteratorProtocol】
struct WolfMan {
    var name: String = ""
    var magicPoint: Int = 0
}

let wolfMen: Array<WolfMan> = [WolfMan(name: "1号"), WolfMan(name: "2号"), WolfMan(name: "3号")]

print("---直接使用 FOR-IN 语句遍历数组-------------------------------------")
for wolf in wolfMen {
    print(wolf)
}

print("---直接使用 IndexingIterator<Array<Element>> 语句遍历数组------------")
var wolfIerator1 = wolfMen.makeIterator()
for wolf in wolfIerator1 {
    print(wolf)
}

print("---直接使用 WHILE和 IndexingIterator<Array<Element>> 语句遍历数组------")
var wolfIterator2 = wolfMen.makeIterator()
while let wolf = wolfIterator2.next() {
    print(wolf)
}

//: ## IteratorProtocol 返回nil, 元素被遍历完后 就返回 nil
print("-------------------------------------------------------------------")
var wolfIterator3 = wolfMen.makeIterator()
print(wolfIterator3.next())
print(wolfIterator3.next())
print(wolfIterator3.next())
print(wolfIterator3.next()) // nil
print(wolfIterator3.next()) // nil
//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
