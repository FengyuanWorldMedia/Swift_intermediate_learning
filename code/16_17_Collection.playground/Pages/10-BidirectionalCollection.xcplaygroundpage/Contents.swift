//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # BidirectionalCollection
//: ## 特点：提供从任何有效索引（不包括集合的startIndex）向前遍历。
//: ## 提供了 reversed ， index(before:) 方法。

//: ### Collection 协议提供了向后索引的方法 index(after:)，
//: ### 而 BidirectionalCollection 进一步 提供了 向前索引的方法index(before:)。
 
//: ## 常见的 BidirectionalCollection 类型
//: ### Array
//: ### ArraySlice
//: ### Range
//: ### Slice
//: ### String
//: ### ContiguousArray
//: ### 等等...

var letters = "丰源天下传媒"
var lastIndex = letters.endIndex

while lastIndex > letters.startIndex {
    lastIndex = letters.index(before: lastIndex)
    print(letters[lastIndex])
}

print("----------------------------------------")

//: ### 我们也可以使用reversed()方法进行反转元素
for value in letters.reversed() {
    print(value)
}




//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
