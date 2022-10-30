//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 遵循Sequence协议

//: ## 先看一个官方的例子
//: ## 遵循Sequence协议, 解锁🔓 Sequence 的更多功能。
struct Countdown: Sequence {
    /// associatedtype Element where Self.Element == Self.Iterator.Element
    let start: Int
    func makeIterator() -> CountdownIterator {
         return CountdownIterator(self)
    }
}

struct CountdownIterator: IteratorProtocol {
    
     typealias Element = Int
     
     let countdown: Countdown
     var times = 0

     init(_ countdown: Countdown) {
         self.countdown = countdown
     }
     
     mutating func next() -> Element? {
         let nextNumber = countdown.start - times
         guard nextNumber > 0 else {
             return nil
         }
         times += 1
         return nextNumber
     }
}

let threeTwoOne = Countdown(start: 3)
for count in threeTwoOne {
    print("\(count)...")
}

//: ## 理解contains，这里已经和有没有 真实的元素没有关系了。【只在意迭代器中的数值】。
threeTwoOne.contains(1)
threeTwoOne.contains(2)
threeTwoOne.contains(3)
threeTwoOne.contains(4)

let firstEle = threeTwoOne.first(where: { $0 > 2 })
print(firstEle!)

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
