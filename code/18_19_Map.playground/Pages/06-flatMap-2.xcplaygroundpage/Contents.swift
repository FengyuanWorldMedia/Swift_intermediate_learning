//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # flatMap 的常用操作 示例

//: ## 1.重复元素
let repeated = [2, 3, 4].flatMap { (value: Int) -> [Int] in
    return [value, value, value]
}
print(repeated)

//: ## 执行过程
//: ### step1.对 元素 2，3，4 进行遍历
//: ### step2.对 元素 2 转换为数组 [2,2,2]
//: ### step3.对 元素 3 转换为数组 [3,3,3]
//: ### step4.对 元素 4 转换为数组 [4,4,4]
//: ### step5.对 [[2,2,2],[3,3,3],[4,4,4]] 进行flat 操作，转换为 [2, 2, 2, 3, 3, 3, 4, 4, 4]

print("--------------------------------------------------------------------------------------------------------------------")
//: ## 2.字符串拼接
extension String {
    func joinDouble(_ element: Character) -> String {
        let characters = self.flatMap {
            return [$0, element, element]
        }.dropLast()
         .dropLast()
        return String(characters)
    }
}

let welcomeString = "丰源天下传媒".joinDouble("🌹")
print(welcomeString) // 丰🌹🌹源🌹🌹天🌹🌹下🌹🌹传🌹🌹媒

print("--------------------------------------------------------------------------------------------------------------------")
//: ## 3.组合操作
let suits = ["♥️", "♦️", "♣️", "♠️"]
let faces = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

//: ### 如果把 suits.flatMap 换成 suits.map 将会产出什么结果？
var cards = suits.flatMap { suit in
    faces.map { face in
        (suit, face)
    }
}

// cards.shuffle()  洗牌
print(cards)

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
