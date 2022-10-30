//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 分出胜负

import Foundation


//: 多人掷骰子的顺序问题

//:        上
//:
//:   左                 右
//:
//:        下

enum TurnOfPlayer {
    case up
    case down
    case left
    case right
    
    func next() -> TurnOfPlayer {
        switch self {
            case .up : return .right
            case .down : return .left
            case .left : return .up
            case .right : return .down
        }
    }
}

//: 骰子🎲 的大小判断
enum Dice: Int8 {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    
    /// 定义 Dice的 【大于 ， 等于 ， 小于】
    static func > (left: Dice, right: Dice) -> Bool {
        return left.rawValue > right.rawValue
    }
    static func == (left: Dice, right: Dice) -> Bool {
        return left.rawValue == right.rawValue
    }
    static func < (left: Dice, right: Dice) -> Bool {
        return left.rawValue < right.rawValue
    }
    
    /// 利用Dice的 【大于 ， 等于 ， 小于】 ，  定于Dice的 【大于等于，小于等于】
    static func >= (left: Dice, right: Dice) -> Bool {
        return left > right || left == right
    }
    static func <= (left: Dice, right: Dice) -> Bool {
        return left < right || left == right
    }
    
    /// 计算骰子🎲 的，输赢的 分数。
    static func - (left: Dice, right: Dice) -> Int {
        let diff = left.rawValue - right.rawValue
        return Int(diff) * 6
    }
    
    
}

let diceNum1 = Dice.one
let diceNum2 = Dice.five

print(diceNum1 < diceNum2)

print(diceNum1 - diceNum2)


//: 讨论
//: 一副牌中（除去大小王）, 给出5张牌 得到 RankingsOfTexas 的一个枚举
struct Card {
  let number: Int
  let color: Int
}

//: TODO
func getRankingsOfTexas(_ cards: [Card]) -> RankingsOfTexas {
    return .RoyalFlush
}

//: 德克萨斯扑克 -- 规则
enum RankingsOfTexas {
    case RoyalFlush                                                     // 同花大顺(最高为Ace（一点）的同花顺)
    case StraightFlush(max: Int)                                         // 同花顺(同一花色，顺序的牌)
    case FourOfAKind(card: Int)                                          // 四条（Four of a Kind，亦称“铁支”、“四张”或“炸弹”）
    case FullHouse(three: Int)                                           // 满堂红(三张同一点数的牌，加一对其他点数的牌)
    case Flush(card1: Int, card2: Int,card3: Int, card4: Int,card5: Int)  // 同花（Flush，简称“花”：五张同一花色的牌)
    case Straight(max: Int)                                              // 顺子(五张顺连的牌)
    case ThreeOfAKind(max: Int)                                          // 三条(有三张同一点数的牌)
    case TwoPairs(pairOne: Int , pairTwo: Int , other: Int)              // 两对(两张相同点数的牌，加另外两张相同点数的牌)
    case OnePair (pair: Int, card3 : Int,card4: Int,card5: Int)          // 一对(两张相同点数的牌)
    case HighCard(max: Int)                                             // 高牌（不符合上面任何一种牌型的牌型，由单牌且不连续不同花的组成，以点数决定大小)
    
    // 计算属性的加入，可以解决 有参数的枚举不能加入 RawValue的缺点。
    var level: Int {
        switch self {
            case .RoyalFlush : return 10
            case .StraightFlush : return 9
            case .FourOfAKind : return 8
            case .FullHouse : return 7
            case .Flush : return 6
            case .Straight : return 5
            case .ThreeOfAKind : return 4
            case .TwoPairs : return 3
            case .OnePair : return 2
            case .HighCard : return 1
        }
    }
    
    static func - (left: RankingsOfTexas, right: RankingsOfTexas)-> Int {
        let diff = left.level - right.level
        if diff != 0 {
            return diff * 6
        }
        // 表示两手牌有 一样的情况，其大小的对比在于 参数的对比。
        switch left {
            case .RoyalFlush :
                return 0
            case .StraightFlush(let max) :
                switch right {
                    case .Straight(let rMax):
                       return (max - rMax) * 6
                    default:
                        print("impossible case")
                        return -1 * 6
                }
            case .FourOfAKind(let card) :
                 return 8 // TODO: 等待实装
            case .FullHouse(let card) :
                 return 7 // TODO: 等待实装
            case .Flush(let card1, let card2, let card3, let card4, let card5) :
                 return 6 // TODO: 等待实装
            case .Straight(let max) :
                 return 5 // TODO: 等待实装
            case .ThreeOfAKind(let three) :
                 return 4 // TODO: 等待实装
            case .TwoPairs(let pairOne , let pairTwo, let other) :
                 return 3 // TODO: 等待实装
            case .OnePair(let pair, let card3, let card4, let card5) :
                return 2 // TODO: 等待实装
            case .HighCard(let max) :
                return 1 // TODO: 等待实装
        }
    }
}


print(RankingsOfTexas.Straight(max: 10).level)


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
