//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # RangeReplaceableCollection
//: ## 特点：可以改变长度。
//: ## 提供了 +， += ，append， insert， removeLast， removeSubrange， removeAll，replaceSubrange 等 方法。
 
//: ## 常见的 RangeReplaceableCollection 类型
//: ### Array
//: ### ArraySlice
//: ### ContiguousArray
//: ### String

var nameOfWolves = ["🐺1号", "🐺2号", "🐺3号"]

nameOfWolves += ["🐺4号", "🐺5号"]
print(nameOfWolves)

nameOfWolves.removeFirst()
print(nameOfWolves)

nameOfWolves.removeSubrange(0..<2)
print(nameOfWolves)

//: ## removeAll(where shouldBeRemoved: (Element) throws -> Bool)
var nameOfWolves2 = ["🐺1号", "🐺2号", "🐺3号"]
nameOfWolves2.removeAll(where:{ $0 == "🐺2号" })
print(nameOfWolves2)

//: ## replaceSubrange
var nums = [10, 20, 30, 40, 50]
nums.replaceSubrange(1...3, with: repeatElement(1, count: 5))
print(nums)


//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
