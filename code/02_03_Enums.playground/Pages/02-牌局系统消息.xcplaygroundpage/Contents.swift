//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 牌局系统消息

import Foundation

struct SystemMessage {
    let toUserIds: [String]?   // nil 的 时候 表示对所有人
    let message: String?       // 发送信息
    let date: Date            // 发送时间
    let isPublic: Bool         // true：对其他人公开 false：对其他人不公开
}

//: 系统发出的信息内容比玩家的信息内容形式上要少一些

let warningMessage = SystemMessage(toUserIds: ["0001"],
                                   message: "时间到了，抓紧时间出牌",
                                   date: Date(),
                                   isPublic: true)

let chargeMessage = SystemMessage(toUserIds: ["0001","0002","0004"],
                                   message: "您的游戏点数已经用完了，请充值",
                                   date: Date(),
                                   isPublic: false)

// 棋牌室
class CardsPlaygound {
    
    func sendSystemMessage(msg: SystemMessage) {
        // 处理信息
        
    }
    
}


var cardsPlaygound = CardsPlaygound()

cardsPlaygound.sendSystemMessage(msg: warningMessage)
cardsPlaygound.sendSystemMessage(msg: chargeMessage)

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
