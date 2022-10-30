//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 玩家入局消息

import Foundation

struct PlayerMessage {
    let userId: String      /// 用户ID
    let message: String?    /// 发送信息
    let date: Date         /// 发送信息时间
    
    let hasJoined: Bool     /// 进入牌局
    let hasLeft: Bool       /// 离开牌局
    
    let isThinking: Bool    /// 思考中
    let isWinner: Bool      /// 赢得牌局
}

/// 这是一个加入的信息
let joinMessage = PlayerMessage(userId: "0001",
                               message: nil,
                               date: Date(),
                               hasJoined: true,
                               hasLeft: false,
                               isThinking: false,
                               isWinner: false)

/// 这是一个打招呼的信息
let textMessage = PlayerMessage(userId: "0002",
                               message: "我是胜利收割者，哈哈哈",
                               date: Date(),
                               hasJoined: false,
                               hasLeft: false,
                               isThinking: false,
                               isWinner: false)

//: 棋牌室
class CardsPlaygound {
    
    func sendMessage(msg: PlayerMessage) {
        // 处理信息
        
    }
    
}

var cardsPlaygound = CardsPlaygound()

cardsPlaygound.sendMessage(msg: joinMessage)
cardsPlaygound.sendMessage(msg: textMessage)

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

