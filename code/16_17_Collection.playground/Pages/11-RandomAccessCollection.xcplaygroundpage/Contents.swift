//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # RandomAccessCollection
//: ## 特点：继承BidirectionalCollection协议，提供了更好的访问性能。
//: ##  提供了 distance ，index(_ i: Int, offsetBy distance: Int, limitedBy limit: Int) 方法。


//: ### 随机访问集合可以将索引移动任意距离，并在O（1）时间内测量索引之间的距离。
//: ### 因此，随机访问和双向收集之间的根本区别在于，依赖于索引移动或距离测量的操作提供了显著提高的效率。
//: ### 例如，随机访问集合的计数属性是在O（1）中计算的，而不需要对整个集合进行迭代

//: ## 遵循该协议RandomAccessCollection协议
//: ### 1.实现 index(_:offsetBy:) 和 distance(from:to:)方法
//: ### 2.在O（1）时间内完成 这两个方法的计算。😅--（协议要求，但是。。。😄，还是遵守协议要求吧。）

//: ## 常见的 RandomAccessCollection 类型
//: ### Array
//: ### ArraySlice
//: ### Range
//: ### Slice
//: ### 等等...

//: ## 在常数时间内，完成 distance 操作
var nameOfWolves = ["🐺1号", "🐺2号", "🐺3号", "🐺4号", "🐺5号"]
nameOfWolves.distance(from: 1, to: 4) // 3

///   - limit: A valid index of the collection to use as a limit. If
///     `distance > 0`, `limit` has no effect if it is less than `i`.
///     Likewise, if `distance < 0`, `limit` has no effect if it is greater
///     than `i`.
///
// 从索引“i”偏移“distance”的索引，除非该索引在移动方向上超出“limit”。在这种情况下，该方法返回“nil”。
nameOfWolves.index(1, offsetBy: 8, limitedBy: 5) //  注意这里的limitedBy使用。
nameOfWolves.index(3, offsetBy: -2, limitedBy: 1)

let numbers = [10, 20, 30, 40, 50]
if let i = numbers.index(numbers.startIndex, offsetBy: -1, limitedBy: 0) { // numbers.endIndex
    print(numbers[i])
} else {
    print("No value")
}

//: ## 值得注意⚠️的是：Repeated类型是 RandomAccessCollection类型
var repeatCollection = repeatElement("丰源天下传媒", count: 3)
repeatCollection.distance(from: 0, to: 1)

zip(repeatElement("丰源天下传媒", count: 3), repeatElement(100, count: 3)).forEach { name, index in
    print("Generated \(name) \(index)")
}

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
