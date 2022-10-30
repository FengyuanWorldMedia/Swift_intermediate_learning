//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 翻牌游戏

//: ## 规则：
//: ### 清一色花色（假定为♥️）的牌，A-2-3-4-5-6-7-8-9-10-J-Q-K， 13张扑克。
//: ### 1.洗牌
//: ### 2.从底部取出一张牌 放到 最顶部，然后把 底部的牌 亮出。
//: ### 3.持续步骤2，直到出牌结束
//: ### 4.亮出牌的顺序为 【♥️A，♥️2，♥️3，♥️4，♥️5，♥️6，♥️7，♥️8，♥️9，♥️10，♥️J，♥️Q，♥️K】

//: ### 求：洗牌后， 牌的顺序？


struct Card {
    var turn: Int        /// 原来牌的顺序(从上至下)
    var name: String?    /// 牌面
    var turnOfOrder: Int? /// 出牌的顺序
}

class CardSorter {
    
    private var cards = [Card]()
    private var sortedCards = [Card]()
    
    private let expectedCards = ["♥️A","♥️2","♥️3","♥️4","♥️5","♥️6","♥️7","♥️8","♥️9","♥️10","♥️J","♥️Q","♥️K"]
    
    init() {
        for i in 0...12 {
            cards.append(Card(turn: i))
        }
    }
    
    func sort() {
        var turn: Int = 0
        while !cards.isEmpty {
            // 1.从底部取出一张牌 放到 最顶部
            let lastCard = cards.removeLast()
            cards.insert(lastCard, at: 0)
            // 2.然后把 底部的牌 亮出
            var showedCard = cards.removeLast()
            showedCard.name = expectedCards[turn]
            showedCard.turnOfOrder = turn
            turn += 1
            
            sortedCards.append(showedCard)
        }
    }
    
    func getSortedCards() -> [Card] {
        return self.sortedCards.sorted(by: {
            return $0.turn < $1.turn
        })
    }
}

var cardSorter = CardSorter()
cardSorter.sort()
let sortedCards = cardSorter.getSortedCards()

print("扑克原来的顺序（从上到下）为：")
for e in sortedCards {
    print("      turn: \(e.turn) , name: \(e.name!) , turnOfOrder: \(e.turnOfOrder!) ")
}

//: ## 以CardSorter为基础，进行程序升级-留给亲爱的听众：
//: ### 1.程序中出现两个数组，是不是 可以只用一个数组实现？
//: ### 2.程序中出现了元素的移动和排序，开销比较大，如何避免元素的移动？
//: ### 3.程序中，出牌的前后，想加入Hook处理，如何设计？ Hook处理，有可能不是必须的。
//: ### 4.想要的排序是否可以DIY？
//: ### 5.如果一次移动2张牌的话，如何才能保证出牌是想要的顺序？
//: ### 6.操作规则是 一个 映射函数，那岂不是成了 无所不能的魔术师，想想如何设计？
//: ### 7.想一想，为了让使用者 这有更多的参与空间，Optional类型该如何使用？

//: ## 在不断的程序设计锻炼中，掌握Swift开发的技能。

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)



