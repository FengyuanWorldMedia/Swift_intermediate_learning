//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 用枚举统一牌局消息

import Foundation

enum Message {
    case msg(userId: String, date: Date, message: String)                     // 发送信息
    case thinking(userId: String, date: Date)                               // 思考中
    case join(userId: String, date: Date)                                  // 进入牌局
    case leave(userId: String, date: Date)                                 // 离开牌局
    case win(userId: String, date: Date)                                   // 赢得牌局
    case systemPrivateMsg(toUserIds: [String]?, date: Date, message: String)  // 系统私人信息
    case systemPublicMsg(toUserIds: [String]?, date: Date, message: String)   // 系统公开信息
}


class CardsPlaygound {
    
    func messageHandler(message: Message) {
        switch message {
        case let .msg(userId: id, date: date, message: message):
            print("[\(date)] 用户 \(id) 发送了信息: \(message)")
        case let .thinking(userId: id, date: date):
            print("[\(date)] 用户 \(id) 正在想着下一步的牌")
        case let .join(userId: id, date: date):
            print("[\(date)] 用户 \(id) 加入了牌局")
        case let .leave(userId: id, date: date):
            print("[\(date)] 用户 \(id) 离开了牌局")
        case let .win(userId: id, date: date):
            print("[\(date)] 用户 \(id) 赢了牌局")
        case let .systemPrivateMsg(toUserIds: users, date: date, message: message):
            print("[\(date)] 系统向用户 \(getUserList(users)) 发送了信息： \(message)" )
        case let .systemPublicMsg(toUserIds: users, date: date, message: message):
            print("[\(date)] 系统向用户 \(getUserList(users)) 发送了信息： \(message),用户列表以外的人也可以看到。" )
        }
    }
    
    private func getUserList(_ toUserIds: [String]?) -> String {
        guard let userIds = toUserIds else {
            return "大家"
        }
        if userIds.isEmpty {
            return "大家"
        }
        return userIds.joined(separator: ",")
    } 
}

let helloMessage = Message.msg(userId: "0001", date: Date(), message: "我这次赢定了，哈哈哈")

let joinMessage = Message.join(userId: "0002", date: Date())

let warningMssage = Message.systemPublicMsg(toUserIds: ["0003"], date: Date(), message: "请在20秒内出牌")

var cardsPlaygound = CardsPlaygound()

cardsPlaygound.messageHandler(message: helloMessage)
cardsPlaygound.messageHandler(message: joinMessage)
cardsPlaygound.messageHandler(message: warningMssage)
 

if case let Message.msg(_, _, message: msg) = helloMessage {
    print("我只关心消息: \(msg)")
}

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

