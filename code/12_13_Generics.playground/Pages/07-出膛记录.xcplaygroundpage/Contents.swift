//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 范型的约束
//: ## 实现CustomDebugStringConvertible, CustomStringConvertible 协议

//: ### 扩展Array ，使其转为Set 类型.
extension Array {
    func mapToSet<T: Hashable>(_ transform: (Element) -> T) -> Set<T> {
        var result = Set<T>()
        for item in self {
            result.insert(transform(item))
        }
        return result
    }
}

//: ### 定义子弹类型
struct Bullet: Hashable, Comparable {
    var type: String
    var speed: Int
    
    static func < (lhs: Bullet, rhs: Bullet) -> Bool {
        return lhs.speed < rhs.speed
    }
    
    static func == (lhs: Bullet, rhs: Bullet) -> Bool {
        return lhs.speed == rhs.speed
    }
}

//: ### 扩展子弹，获取其信息
extension Bullet: CustomDebugStringConvertible, CustomStringConvertible {
    
    var description: String {
        return "Log:: 子弹类型\(type), 子弹速度:\(speed)"
    }
    
    var debugDescription: String {
        return "Debug Log:: - 子弹类型\(type), 子弹速度:\(speed)"
    }
}

//: ### 定义Log
typealias LOG_OBJECT = CustomStringConvertible & CustomDebugStringConvertible
struct Logger {
    
    var debugMode: Bool = false
    
    func log<T>(obj: T?) where T: LOG_OBJECT {
        if let logObj = obj {
            if debugMode {
                print(logObj.debugDescription)
            } else {
                print(logObj.description)
            }
        } else {
            print("Nothing")
        }
    }
}


//: ### 增加范型的约束，使其可以直接打印Log信息.
struct BulletContainer<B: Comparable & Hashable & LOG_OBJECT> {
    
    private let logger = Logger()
    
    private var bulletDic: Dictionary<String , B> = [:]
    
    mutating func addBullet(key: String , bullet: B) {
        logger.log(obj: bullet)
        self.bulletDic[key] = bullet
    }
    
    mutating func popBullet(key: String) -> B? {
        let bullet = self.bulletDic[key]
        logger.log(obj: bullet)
        return bullet
    }
    
    func morePowerfull(than: BulletContainer<B>) -> Bool {
        let keys = Array(bulletDic.keys).mapToSet({$0})
        let keys2 = Array(than.bulletDic.keys).mapToSet({$0})
        let sameBullets = keys.intersection(keys2)
        var winCount = 0
        for e in sameBullets {
            print(e)
            let oneBullet = self.bulletDic[e]!
            let anotherBullet = than.bulletDic[e]!
            if oneBullet == anotherBullet {
                continue
            } else if oneBullet > anotherBullet {
                winCount += 1
            } else {
                winCount -= 1
            }
        }
        return winCount > 0
    }
}

 
var container1 = BulletContainer<Bullet>()
container1.addBullet(key: "第1发子弹", bullet: Bullet(type: "A-1", speed: 17))
container1.addBullet(key: "第2发子弹", bullet: Bullet(type: "A-1", speed: 16))

_ = container1.popBullet(key: "第1发子弹")
_ = container1.popBullet(key: "第2发子弹")
_ = container1.popBullet(key: "第3发子弹")

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
