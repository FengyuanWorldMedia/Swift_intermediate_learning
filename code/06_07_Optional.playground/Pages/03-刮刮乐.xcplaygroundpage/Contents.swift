//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)


//: # 刮刮乐数据结构设计和相关操作(复习)

import Foundation

// 设计一个刮刮乐数据结构(体会Optional类型数据的基本使用方法)
// 1.一个刮刮乐，一共可以刮奖6次
// 2.为了避免不中奖的尴尬，公共区域设置一个 鼓励奖(有可能没有)，如果中奖了 鼓励奖失效。

struct ScratchCards {
    
    // 参与奖的 构造方法 init? 可以看出， 参与奖也不一定有。
    let award = ParticipationAward()
    
    // 为什么设置为 Card 的数据， 因为卡片刮奖区 一定是有的。
    var cards: [Card] = []
    
    // 为什么要设置为 String？ 类型， 方便福彩中心 使用，再次更改发行信息。
    var descrption: String? = "开心刮刮乐娱乐-发行"
    
    init() {
        for num in 1...6 {
            cards.append(Card(num: num, yes: Bool.random()))
        }
    }
}

struct Card {
    var num: Int
    private let awardNameList = ["🚴‍♀️" , "500¥" , "10,000¥" , "🚗" , "全球🚢旅游"]
    // 如果没有中奖的话， 这个名字是 nil
    var awardName: String?
    
    init(num: Int, yes: Bool) {
        if yes {
            let awardNameCount = awardNameList.count
            awardName = awardNameList[Int.random(in: 0..<awardNameCount)]
        }
        self.num = num
    }
    
}

struct ParticipationAward {
    private let awardNameList = ["🍎" , "🌹" , "🔋" , "🎩" , "🪆"]
    
    var awardName: String
    var price: Float
    
    init?() {
        if !Bool.random() {
            return nil
        } else {
            let awardNameCount = awardNameList.count
            awardName = awardNameList[Int.random(in: 0..<awardNameCount)]
            price = Float.random(in: 2.5...15.5)
        }
    }
}


//: ## 刮刮乐的基本 Optional 操作
var scratchCards = ScratchCards()

//: ### 这张刮刮乐，是哪家公司发行的？  如果没有 公司发行信息，打印 “还没流入市场”
print(scratchCards.descrption ?? "还没流入市场")
scratchCards.descrption = "刮刮乐娱乐公司"
print(scratchCards.descrption!)

//: ### 刮刮乐的参与将是什么
print(scratchCards.award?.awardName ?? "没有参与奖")

//: ### 刮刮乐 第5个刮奖 是什么？
print(scratchCards.cards[0].awardName ?? "第0个刮奖 什么也没有")
print(scratchCards.cards[1].awardName ?? "第1个刮奖 什么也没有")
print(scratchCards.cards[2].awardName ?? "第2个刮奖 什么也没有")
print(scratchCards.cards[3].awardName ?? "第3个刮奖 什么也没有")
print(scratchCards.cards[4].awardName ?? "第4个刮奖 什么也没有")
print(scratchCards.cards[5].awardName ?? "第5个刮奖 什么也没有")


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
